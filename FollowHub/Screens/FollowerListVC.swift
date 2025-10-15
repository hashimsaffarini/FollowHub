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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
