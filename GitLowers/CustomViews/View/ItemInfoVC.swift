//
//  UserInfoView.swift
//  GitLowers
//
//  Created by Nurbek on 19/01/24.
//

import UIKit
import SnapKit

protocol ItemInfoDelegate: AnyObject {
    func didTapProfile(for user: UserInfoModel)
    func didTapFollowers(for user: UserInfoModel)
}

class ItemInfoVC: UIViewController {
    
    private var stackView = UIStackView()
    var actionButton = GLButton()
    var itemInfoViewOne = UserInfoItemView()
    var itemInfoViewTwo = UserInfoItemView()
    
    var user: UserInfoModel!
    weak var delegate: ItemInfoDelegate!
    
    init(user: UserInfoModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.user = user
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layoutUI()
    }
    
    
    private func configure() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 15
    }
    
    
    private func layoutUI() {
        [stackView, actionButton].forEach {
            view.addSubview($0)
        }
        
        stackView.distribution = .equalSpacing
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(GlobalConstants.padding16)
            $0.leading.equalTo(view.snp.leading).offset(GlobalConstants.padding25)
            $0.trailing.equalTo(view.snp.trailing).offset(-GlobalConstants.padding25)
            $0.height.equalTo(60)
        }
        
        actionButton.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(GlobalConstants.padding16)
            $0.trailing.equalTo(view.snp.trailing).offset(-GlobalConstants.padding16)
            $0.bottom.equalTo(view.snp.bottom).offset(-GlobalConstants.padding16)
            $0.height.equalTo(GlobalConstants.defaultHeight)
        }
    }
    
    
    @objc func actionButtonTapped() {}
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
