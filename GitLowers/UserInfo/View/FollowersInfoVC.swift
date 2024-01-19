//
//  FollowersInfoVC.swift
//  GitLowers
//
//  Created by Nurbek on 18/01/24.
//

import UIKit
import SnapKit

class UserInfoVC: UIViewController {
    
    var username: String!
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = username
        
        setNavigationBar()
    }
    
    
    private func setNavigationBar() {
        let button = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = button
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension UserInfoVC {
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}
