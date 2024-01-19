//
//  GLBodyLabel.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit

class GLBodyLabel: UILabel {
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        
        self.textAlignment = textAlignment
        
        configure()
    }
    
    
    private func configure() {
        font = .preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byWordWrapping
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
