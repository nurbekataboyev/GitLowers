//
//  GLTextField.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit

class GLTextField: UITextField {
    
    init(placeholderText: String) {
        super.init(frame: .zero)
        
        placeholder = placeholderText
        
        configure()
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray3.cgColor
        
        textAlignment = .center
        tintColor = .label
        autocorrectionType = .no
        autocapitalizationType = .none
        
        font = .systemFont(ofSize: 20, weight: .regular)
        adjustsFontSizeToFitWidth = true
        returnKeyType = .go
        clearButtonMode = .whileEditing
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
