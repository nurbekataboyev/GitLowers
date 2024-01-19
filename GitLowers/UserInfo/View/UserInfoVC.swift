//
//  FollowersInfoVC.swift
//  GitLowers
//
//  Created by Nurbek on 18/01/24.
//

import UIKit
import SnapKit

class UserInfoVC: UIViewController {
    
    var username: String!
    private let networkManager = NetworkManager.shared
    
    private var profileImageView = GLImageView()
    private var loginLabel = GLTitleLabel(fontSize: 32, textAlignment: .left)
    private var nameLabel = GLBodyLabel(textAlignment: .left)
    private var locationImageView = GLImageView()
    private var locationLabel = GLBodyLabel(textAlignment: .left)
    private var bioLabel = GLBodyLabel(textAlignment: .left)
    private var dateLabel = GLBodyLabel(textAlignment: .center)
    private var mainStack = UIStackView()
    
    private var topView: UserInfoView!
    private var bottomView: UserInfoView!
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        getUserInfo(forUsername: self.username)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = username
        
        setNavigationBar()
        configure()
        configureStackView()
        layout()
    }
    
    
    private func setNavigationBar() {
        let button = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = button
    }
    
    
    private func configure() {
        nameLabel.font = .systemFont(ofSize: 20, weight: .regular)
        locationLabel.font = .systemFont(ofSize: 18, weight: .regular)
        bioLabel.font = .systemFont(ofSize: 18, weight: .regular)
        bioLabel.numberOfLines = 3
        
        profileImageView.layer.cornerRadius = 10
        locationImageView.image = GlobalImages.placeholder
    }
    
    
    private func getUserInfo(forUsername username: String) {
        Task {
            let user = try await networkManager.getUserInfo(forUsername: username)
            setUserInfo(forUser: user)
            configureUserInfoView(forUser: user)
        }
    }
    
    
    private func configureStackView() {
        mainStack.axis = .vertical
        mainStack.spacing = GlobalConstants.padding16
        view.addSubview(mainStack)
    }
    
    
    private func configureUserInfoView(forUser user: UserInfoModel) {
        topView = UserInfoView(user: user)
        bottomView = UserInfoView(user: user)
        
        mainStack.addArrangedSubview(topView)
        mainStack.addArrangedSubview(bottomView)
    }
    
    
    private func setUserInfo(forUser user: UserInfoModel) {
        profileImageView.downloadImage(url: user.avatarUrl)
        loginLabel.text = user.login
        nameLabel.text = user.name ?? "no_username"
        locationLabel.text = user.location ?? "no_location"
        bioLabel.text = user.bio ?? "no_bio"
        dateLabel.text = "GitHub Since " + user.createdAt.formatted(date: .long, time: .omitted)
    }
    
    
    private func layout() {
        [profileImageView, loginLabel, nameLabel, locationImageView, locationLabel, bioLabel, dateLabel].forEach {
            view.addSubview($0)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(GlobalConstants.padding16)
            $0.leading.equalTo(view.snp.leading).offset(GlobalConstants.padding16)
            $0.size.equalTo(110)
        }
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(GlobalConstants.padding16)
            $0.trailing.equalTo(view.snp.trailing).offset(-GlobalConstants.padding16)
            $0.height.equalTo(36)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView.snp.centerY).offset(5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(GlobalConstants.padding16)
            $0.trailing.equalTo(view.snp.trailing).offset(-GlobalConstants.padding16)
        }
        
        locationImageView.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView.snp.bottom)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(GlobalConstants.padding16)
            $0.size.equalTo(25)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationImageView.snp.centerY)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(4)
            $0.trailing.equalTo(view.snp.trailing).offset(-GlobalConstants.padding16)
        }
        
        bioLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(GlobalConstants.padding16)
            $0.leading.equalTo(view.snp.leading).offset(GlobalConstants.padding16)
            $0.trailing.equalTo(view.snp.trailing).offset(-GlobalConstants.padding16)
            $0.height.equalTo(90)
        }
        
        mainStack.snp.makeConstraints {
            $0.top.equalTo(bioLabel.snp.bottom).offset(GlobalConstants.padding16)
            $0.leading.equalTo(view.snp.leading).offset(GlobalConstants.padding16)
            $0.trailing.equalTo(view.snp.trailing).offset(-GlobalConstants.padding16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(mainStack.snp.bottom).offset(GlobalConstants.padding16)
            $0.leading.equalTo(view.snp.leading).offset(GlobalConstants.padding16)
            $0.trailing.equalTo(view.snp.trailing).offset(-GlobalConstants.padding16)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension UserInfoVC {
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}
