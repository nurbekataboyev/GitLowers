//
//  FollowerItemVC.swift
//  GitLowers
//
//  Created by Nurbek on 20/01/24.
//

import UIKit

class FollowerItemVC: UserInfoView {
    
    var user: UserInfoModel
    
    init(user: UserInfoModel) {
        self.user = user
        super.init()
        
        self.firstItemInfoView.setItem(withType: .followers, withCount: user.followers)
        self.secondItemInfoView.setItem(withType: .following, withCount: user.following)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
