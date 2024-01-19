//
//  UserInfoView.swift
//  GitLowers
//
//  Created by Nurbek on 19/01/24.
//

import UIKit
import SnapKit

class UserInfoView: UIView {
    
    init(user: UserInfoModel) {
        super.init(frame: .zero)
        
        print(user)
        
        configure()
    }
    
    
    private func configure() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 15
        
        self.snp.makeConstraints {
            $0.top.equalTo(super.snp.top)
            $0.leading.equalTo(super.snp.leading).offset(GlobalConstants.padding16)
            $0.trailing.equalTo(super.snp.trailing).offset(-GlobalConstants.padding16)
            $0.height.equalTo(150)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
