//
//  GLAlert.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit

class GLAlert: UIAlertController {
    
    init(title: String, message: String, actionTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
        self.message = message
        self.addAction(UIAlertAction(title: actionTitle, style: .cancel))
    }
    
    override var preferredStyle: UIAlertController.Style {
        return .alert
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
