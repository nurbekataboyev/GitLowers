//
//  ItemInfoView.swift
//  GitLowers
//
//  Created by Nurbek on 20/01/24.
//

import UIKit
import SnapKit

enum ItemType {
    case repos, gists, followers, following
}

class ItemInfoView: UIView {
    
    private var symbolImageView = GLImageView()
    private var titleLabel = GLTitleLabel(fontSize: 20, textAlignment: .left)
    private var countLabel = GLTitleLabel(fontSize: 20, textAlignment: .center)
    
    
    init() {
        super.init(frame: .zero)
        
//        self.snp.makeConstraints {
//            $0.width.equalTo(120)
//            $0.height.equalTo(70)
//        }
        
        configure()
    }
    
    
    func setItem(withType type: ItemType, withCount count: Int) {
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
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.size.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(symbolImageView.snp.centerY)
            $0.leading.equalTo(symbolImageView.snp.leading).offset(5)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(25)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(25)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
