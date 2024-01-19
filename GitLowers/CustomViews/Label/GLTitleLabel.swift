//
//  GLTitleLabel.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit

class GLTitleLabel: UILabel {
    
    init(fontSize: CGFloat, textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        
        self.font = .systemFont(ofSize: fontSize, weight: .bold)
        self.textAlignment = textAlignment
        
        configure()
    }
    
    
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
