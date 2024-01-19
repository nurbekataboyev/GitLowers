//
//  FollowersCollectionCell.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit
import SnapKit

class FollowersCollectionCell: UICollectionViewCell {
    
    static let reuseID = "FollowersCollectionCell"
    
    let profileImageView = GLImageView()
    let usernameLabel = GLTitleLabel(fontSize: 18, textAlignment: .center)
    
    
    public func setFollowers(follower: FollowersModel) {
        self.profileImageView.downloadImage(url: follower.avatarUrl)
        self.usernameLabel.text = follower.login
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [profileImageView, usernameLabel].forEach {
            addSubview($0)
        }
        
        configure()
        layout()
    }
    
    
    private func configure() {
        profileImageView.layer.cornerRadius = 10
    }
    
    
    private func layout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(self.snp.width)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(GlobalConstants.padding10)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(20)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
