//
//  FavoritesVC.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit
import SnapKit

class FavoritesVC: UIViewController {
    
    private let persistenceManager = PersistenceManager.shared
    
    private var tableView = UITableView()
    private var favorites: [FollowersModel] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFavorites()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favorites"
        
        configureTableView()
    }
    
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        
        tableView.rowHeight = 80
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.reuseID)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func getFavorites() {
        persistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.favorites = favorites
            case .failure(let error):
                print(error.rawValue)
            }
            
            tableView.reloadData()
        }
    }
    
}


extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseID, for: indexPath) as! FavoritesTableViewCell
        
        cell.selectionStyle = .none
        
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowersVC(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        
        persistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                return
            }
            
            print(error.rawValue)
        }
    }
    
    
}
