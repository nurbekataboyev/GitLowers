//
//  SearchVC.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {
    
    let searchTextField = GLTextField(placeholderText: "Enter a Username")
    let actionButton = GLButton(backgroundColor: .systemGreen, title: "Get Followers")
    let logoImageView = GLImageView()
    
    private var isUsernameEntered: Bool {
        return !searchTextField.text!.isEmpty
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        searchTextField.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        [searchTextField, actionButton, logoImageView].forEach {
            view.addSubview($0)
        }
        
        configure()
        dismissKeyboard()
        layout()
    }
    
    
    private func configure() {
        logoImageView.image = GlobalImages.gitHubLogo
        searchTextField.delegate = self
        
        actionButton.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
    }
    
    
    private func dismissKeyboard() {
        let gesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(gesture)
    }
    
    
    @objc private func pushVC() {
        guard isUsernameEntered else {
            let alert = UIAlertController(title: "Something went wrong", message: "Please enter valid username", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        searchTextField.resignFirstResponder()
        
        let destinationVC = FollowersVC(username: searchTextField.text!)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    private func layout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(70)
            $0.centerX.equalTo(view.snp.centerX)
            $0.size.equalTo(220)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(60)
            $0.leading.equalTo(view.snp.leading).offset(GlobalConstants.padding25)
            $0.trailing.equalTo(view.snp.trailing).offset(-GlobalConstants.padding25)
            $0.height.equalTo(60)
        }
        
        actionButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            $0.leading.equalTo(view.snp.leading).offset(GlobalConstants.padding25)
            $0.trailing.equalTo(view.snp.trailing).offset(-GlobalConstants.padding25)
            $0.height.equalTo(50)
        }
    }
    
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushVC()
        return true
    }
}
