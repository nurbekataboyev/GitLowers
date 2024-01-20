//
//  FollowerItemView.swift
//  GitLowers
//
//  Created by Nurbek on 21/01/24.
//

import UIKit
import SnapKit

class FollowerItemView: ItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    private func configure() {
        itemInfoViewOne.setItemInfo(type: .followers, withCount: user.followers)
        itemInfoViewTwo.setItemInfo(type: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapFollowers(for: user)
    }
    
}
