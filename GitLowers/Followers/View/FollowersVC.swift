//
//  FollowersVC.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit

class FollowersVC: UIViewController {
    
    private let networkManager = NetworkManager.shared
    var username: String!
    private var page: Int = 1
    private var followers: [FollowersModel] = []
    private var filteredFollowers: [FollowersModel] = []
    private var isSearching: Bool = false
    private var isLoadingFollowers: Bool = false
    private var hasMoreFollowers: Bool = true
    
    private var searchController = UISearchController()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, FollowersModel>!
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = username
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureSearchController()
        configureCollectionView()
        getFollowers(forUser: username, page: page)
        configureDataSource()
    }
    
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.itemSize = .init(width: (view.frame.width / 3) - 14, height: 170)
        layout.sectionInset = .init(top: 10, left: 10, bottom: 0, right: 10)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(FollowersCollectionCell.self, forCellWithReuseIdentifier: FollowersCollectionCell.reuseID)
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, FollowersModel>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCollectionCell.reuseID, for: indexPath) as! FollowersCollectionCell
            cell.setFollowers(follower: itemIdentifier)
            return cell
        })
    }
    
    
    private func getFollowers(forUser username: String, page: Int) {
        isLoadingFollowers = true
        showLoadingScreen()
        
        Task {
            do {
                let followers = try await networkManager.getFollowers(forUser: username, page: page)
                updateUI(withFollowers: followers)
            } catch {
                if let error = error as? GLError {
                    let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    present(alert, animated: true)
                }
            }
            dismissLoadingScreen()
        }
        isLoadingFollowers = false
    }
    
    
    private func updateUI(withFollowers followers: [FollowersModel]) {
        if followers.count < 100 {
            hasMoreFollowers = false
        }
        
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            DispatchQueue.main.async {
                self.showEmptyStateView(withTitle: "This user has no followers", message: "You can be first follower of this user", toView: self.view)
            }
        }
        
        updateData(withFollowers: self.followers)
    }
    
    
    private func updateData(withFollowers followers: [FollowersModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FollowersModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension FollowersVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            filteredFollowers.removeAll()
            updateData(withFollowers: followers)
            isSearching = false
            return
        }
        
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(text.lowercased()) }
        updateData(withFollowers: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(withFollowers: followers)
    }
}


extension FollowersVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedUser: FollowersModel
        
        if isSearching {
            selectedUser = filteredFollowers[indexPath.row]
        } else {
            selectedUser = followers[indexPath.row]
        }
        
        let destinationVC = UserInfoVC(username: selectedUser.login)
        destinationVC.delegate = self
        present(UINavigationController(rootViewController: destinationVC), animated: true)
        
        isSearching = false
        searchController.searchBar.resignFirstResponder()
        searchController.searchBar.text = nil
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastRow = followers.count - 1
        let lastIndex = IndexPath(row: lastRow, section: 0)
        
        guard lastIndex == indexPath, hasMoreFollowers, !isLoadingFollowers else { return }
        
        page += 1
        getFollowers(forUser: username, page: page)
    }
}


extension FollowersVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        
        getFollowers(forUser: username, page: page)
    }
}
