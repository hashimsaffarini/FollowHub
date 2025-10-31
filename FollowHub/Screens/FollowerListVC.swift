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
    var page = 1
    var hasMoreFollowers = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(name: userName, page: page)
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
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    

    
    func getFollowers(name : String , page : Int) {
        showLoadingView()
        NetworkManager.shared.getFollower(for: userName, page: page) { [weak self] result in
            guard let self = self else {return}
            Task { @MainActor in
                dismissLoadingView()
                switch result {
                case .success(let followers):
                    if followers.count < 100 {self.hasMoreFollowers = false}
                    self.followers.append(contentsOf: followers)
                    if followers.isEmpty {
                        let message = "This user dosen't have any followers 😞."
                        showEmptyStateView(with: message, in: view)
                        return
                    }
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

extension FollowerListVC : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else {return}
            page+=1
            getFollowers(name: userName, page: page )
        }
    }
}
