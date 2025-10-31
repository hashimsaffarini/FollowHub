//
//  UIViewController+Ext.swift
//  FollowHub
//
//  Created by Hashim Saffarini on 15/10/2025.
//

import UIKit

fileprivate var containerView : UIView!

extension UIViewController {
    func presentGFAlertOnMainThred(title: String , message: String , buttonTitle : String){
        DispatchQueue.main.async {
            let alert = GFAlertVC(alertTitle: title , alertMessage: message, buttonTitle: buttonTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true)
        }
    }
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) {containerView.alpha = 0.8}
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
            containerView.removeFromSuperview()
            containerView = nil
    }
}
