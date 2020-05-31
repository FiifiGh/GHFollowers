//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by KOFI on 5/17/20.
//  Copyright © 2020 fiifi_gh. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController {
    
    enum Section{
        case main
    }
    
    var username:String!
    var followers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section,Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false,animated:true)
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = username
    }
    
    
    func getFollowers(username: String,page: Int){
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else{ return }
            switch result{
                case.success(let followers):
                    if followers.count < 100 {self.hasMoreFollowers = false}
                    self.followers.append(contentsOf:followers)
                    self.updateData()
                case.failure(let error):
                    self.presentGFAlertOnMainThread(title: "Bad stuff", message: error.rawValue, buttonTitle: "ok")
            }
        }
        
    }
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
        
    
    func configureDataSource(){
        datasource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(){
        var snapShot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {self.datasource.apply(snapShot, animatingDifferences: true, completion: nil)}
    }

}


extension FollowersListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if(offsetY > contentHeight - height){
            guard hasMoreFollowers else {return}
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}