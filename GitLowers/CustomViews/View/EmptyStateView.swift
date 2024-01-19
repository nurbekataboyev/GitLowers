//
//  EmptyStateView.swift
//  GitLowers
//
//  Created by Nurbek on 18/01/24.
//

import UIKit
import SnapKit

class EmptyStateView: UIView {
    
    private var titleLabel = GLTitleLabel(fontSize: 22, textAlignment: .center)
    private var messageLabel = GLBodyLabel(textAlignment: .center)
    
    init(title: String, message: String) {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        
        titleLabel.text = title
        messageLabel.text = message
        
        configure()
    }
    
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(messageLabel)
        
        titleLabel.numberOfLines = .max
        messageLabel.numberOfLines = .max
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(100)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(25)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(GlobalConstants.padding16)
            $0.leading.equalTo(self.snp.leading).offset(GlobalConstants.padding25)
            $0.trailing.equalTo(self.snp.trailing).offset(-GlobalConstants.padding25)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
