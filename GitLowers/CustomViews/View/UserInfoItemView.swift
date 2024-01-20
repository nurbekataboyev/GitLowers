//
//  UserInfoItemView.swift
//  GitLowers
//
//  Created by Nurbek on 21/01/24.
//

import UIKit
import SnapKit

enum ItemType {
    case repos, gists, followers, following
}

class UserInfoItemView: UIView {
    
    private var symbolImageView = GLImageView()
    private var titleLabel = GLTitleLabel(fontSize: 15, textAlignment: .left)
    private var countLabel = GLTitleLabel(fontSize: 15, textAlignment: .center)
    
    
    init() {
        super.init(frame: .zero)
        
        configure()
    }
    
    
    public func setItemInfo(type: ItemType, withCount count: Int) {
        switch type {
        case .repos:
            titleLabel.text = "Public Repos"
        case .gists:
            titleLabel.text = "Public Gists"
        case .followers:
            titleLabel.text = "Followers"
        case .following:
            titleLabel.text = "Following"
        }
        
        symbolImageView.image = GlobalImages.placeholder
        countLabel.text = "\(count)"
    }
    
    
    private func configure() {
        [symbolImageView, titleLabel, countLabel].forEach {
            addSubview($0)
        }
        
        symbolImageView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.size.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(symbolImageView.snp.centerY)
            $0.leading.equalTo(symbolImageView.snp.trailing).offset(5)
            $0.trailing.equalTo(self.snp.trailing)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(symbolImageView.snp.bottom).offset(5)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
