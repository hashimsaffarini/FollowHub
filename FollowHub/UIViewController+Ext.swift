//
//  UIViewController+Ext.swift
//  FollowHub
//
//  Created by Hashim Saffarini on 15/10/2025.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainThred(title: String , message: String , buttonTitle : String){
        DispatchQueue.main.async {
            let alert = GFAlertVC(alertTitle: title , alertMessage: message, buttonTitle: buttonTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true)
        }
    }
}
