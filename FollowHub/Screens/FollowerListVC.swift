//
//  FollowerListVC.swift
//  FollowHub
//
//  Created by Hashim Saffarini on 13/10/2025.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section: Int { case main }
    
    var userName : String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower.ID>!
    var followers : [Follower] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers()
        configureDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    

    
    func getFollowers() {
        NetworkManager.shared.getFollower(for: userName, page: 1) { [weak self] result in
            guard let self = self else {return}
            
            Task { @MainActor in
                switch result {
                case .success(let followers):
                    self.followers = followers
                    self.updateData()
                case .failure(let error):
                    self.presentGFAlertOnMainThred(
                        title: "Bad Stuff Happened",
                        message: error.rawValue,
                        buttonTitle: "Ok"
                    )
                }
            }
        }
    }

    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower.ID>(collectionView: collectionView) { collectionView, indexPath, followerID in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: self.followers[indexPath.row])
            return cell
        }
    }
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section , Follower.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers.map { $0.login })
        Task{ @MainActor in
            dataSource.apply(snapshot , animatingDifferences: true)
        }
      
    }
    
}
