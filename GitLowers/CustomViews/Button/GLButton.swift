//
//  GLButton.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit

class GLButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    
    public func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
