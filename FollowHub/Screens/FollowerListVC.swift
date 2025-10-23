//
//  FollowerListVC.swift
//  FollowHub
//
//  Created by Hashim Saffarini on 13/10/2025.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var userName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollower(for: userName, page: 1) { result in
            switch result {
            case .success(let follower):
                print(follower)
            case .failure(let error):
                self.presentGFAlertOnMainThred(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
