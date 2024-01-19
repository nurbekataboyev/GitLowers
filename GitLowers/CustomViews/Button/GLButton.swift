//
//  GLButton.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit

class GLButton: UIButton {
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        
        configure()
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
