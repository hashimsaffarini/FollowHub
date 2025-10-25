//
//  FollowerListVC.swift
//  FollowHub
//
//  Created by Hashim Saffarini on 13/10/2025.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section: Int {
        case main
    }
    
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding : CGFloat = 12
        let itemMinimumItemSpacing : CGFloat = 10
        let availabelWidth = width - (padding * 2) - (itemMinimumItemSpacing * 2)
        let itemWidth  = availabelWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollower(for: userName, page: 1) { result in
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
