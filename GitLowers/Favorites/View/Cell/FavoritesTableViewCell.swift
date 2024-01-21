//
//  FavoritesTableViewCell.swift
//  GitLowers
//
//  Created by Nurbek on 22/01/24.
//

import UIKit
import SnapKit

class FavoritesTableViewCell: UITableViewCell {
    
    static let reuseID = "FavoritesTableViewCell"
    
    private var profileImageView = GLImageView()
    private var usernameLabel = GLTitleLabel(fontSize: 25, textAlignment: .left)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        configure()
    }
    
    
    public func set(favorite: FollowersModel) {
        profileImageView.downloadImage(url: favorite.avatarUrl)
        usernameLabel.text = favorite.login
    }
    
    
    private func configure() {
        addSubview(profileImageView)
        addSubview(usernameLabel)
        
        profileImageView.layer.cornerRadius = 10
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(GlobalConstants.padding10)
            $0.bottom.equalTo(self.snp.bottom).offset(-GlobalConstants.padding10)
            $0.leading.equalTo(self.snp.leading).offset(GlobalConstants.padding10)
            $0.width.equalTo(profileImageView.snp.height)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView.snp.centerY)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(GlobalConstants.padding25)
            $0.trailing.equalTo(self.snp.trailing).offset(-GlobalConstants.padding25)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
