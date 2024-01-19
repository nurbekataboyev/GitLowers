//
//  TestVC.swift
//  GitLowers
//
//  Created by Nurbek on 18/01/24.
//

import UIKit

class TestVC: UIViewController {
    
    enum TestSection {
        case main
    }

    var username: String!
    var followers: [FollowersModel] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<TestSection, FollowersModel>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemYellow
        
        collectionView.register(FollowersCollectionCell.self, forCellWithReuseIdentifier: FollowersCollectionCell.reuseID)
    }
    
    
    private func getFollowers() {
        NetworkManager.shared.testGetFollowers(username: username) { result, error in
            
            self.followers = result!
            self.updateData()
            
        }
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<TestSection, FollowersModel>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCollectionCell.reuseID, for: indexPath) as! FollowersCollectionCell
            cell.set(follower: follower)
            cell.backgroundColor = .systemOrange
            return cell
        })
    }
    
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<TestSection, FollowersModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
