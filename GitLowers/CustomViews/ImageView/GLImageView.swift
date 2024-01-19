//
//  GLImageView.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit

class GLImageView: UIImageView {
    
    private let networkManager = NetworkManager.shared
    
    init() {
        super.init(frame: .zero)
        
        configure()
    }
    
    private func configure() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
