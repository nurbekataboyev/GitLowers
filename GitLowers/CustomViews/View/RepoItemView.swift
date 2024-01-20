//
//  RepoItemView.swift
//  GitLowers
//
//  Created by Nurbek on 21/01/24.
//

import UIKit
import SnapKit

class RepoItemView: ItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    private func configure() {
        itemInfoViewOne.setItemInfo(type: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.setItemInfo(type: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapProfile(for: user)
    }
    
}
