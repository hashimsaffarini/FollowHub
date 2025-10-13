//
//  SearchVC.swift
//  FollowHub
//
//  Created by Hashim Saffarini on 12/10/2025.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let userNameTextField = GFTextField()
    let callToAcionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        view.addSubview(userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            userNameTextField.leadingAnchor.constraint(equalTo:view.leadingAnchor , constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo:view.trailingAnchor , constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureButton(){
        view.addSubview(callToAcionButton)
        NSLayoutConstraint.activate([
            callToAcionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToAcionButton.heightAnchor.constraint(equalToConstant: 50),
            callToAcionButton.leadingAnchor.constraint(equalTo:view.leadingAnchor , constant: 50),
            callToAcionButton.trailingAnchor.constraint(equalTo:view.trailingAnchor , constant: -50)
        ])
    }
    
}
