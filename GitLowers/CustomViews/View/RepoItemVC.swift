//
//  RepoItemVC.swift
//  GitLowers
//
//  Created by Nurbek on 20/01/24.
//

import UIKit

class RepoItemVC: UserInfoView {
    
    var user: UserInfoModel
    
    init(user: UserInfoModel) {
        self.user = user
        super.init()
        
        self.firstItemInfoView.setItem(withType: .repos, withCount: user.publicRepos)
        self.secondItemInfoView.setItem(withType: .gists, withCount: user.publicGists)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
