//
//  TabBarVC.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit

class TabBarVC: UITabBarController {
    
    private let tabBarData: [TabBarModel] = [
        TabBarModel(title: "Search", image: UIImage(systemName: "magnifyingglass"),vc: SearchVC()),
        TabBarModel(title: "Favorite", image: UIImage(systemName: "star.fill"), vc: FavoritesVC()),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    
    private func setupTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .systemGreen
        tabBar.unselectedItemTintColor = .systemGray
        
        var customVC: [UIViewController] = []
        
        for tabBarModel in tabBarData {
            let navigationController = UINavigationController(rootViewController: tabBarModel.vc)
            navigationController.navigationBar.backgroundColor = .systemBackground
            navigationController.tabBarItem.title = tabBarModel.title
            navigationController.tabBarItem.image = tabBarModel.image
            customVC.append(navigationController)
        }
        
        setViewControllers(customVC, animated: false)
    }
    
    
}


extension TabBarVC {
    struct TabBarModel {
        let title: String
        let image: UIImage?
        let vc: UIViewController
    }
}
