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
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
