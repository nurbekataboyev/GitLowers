//
//  Extensions.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit
import SafariServices

private var containerView: UIView!

extension UIViewController {
    func showLoadingScreen() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        
        containerView.addSubview(activityIndicator)
        activityIndicator.center = containerView.center
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingScreen() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}


extension UIViewController {
    func showEmptyStateView(withTitle title: String, message: String, toView view: UIView) {
        let emptyState = EmptyStateView(title: title, message: message)
        emptyState.frame = view.bounds
        view.addSubview(emptyState)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}


extension UIImageView {
    func downloadImage(url: String) {
        Task {
            image = await NetworkManager.shared.downloadImage(from: url) ?? GlobalImages.placeholder
        }
    }
}
