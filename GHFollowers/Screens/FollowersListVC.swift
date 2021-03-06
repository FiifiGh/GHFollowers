//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by KOFI on 5/17/20.
//  Copyright © 2020 fiifi_gh. All rights reserved.
//

import UIKit

protocol FollowersListVCDelegate: class {
    func didRequestFollwer(for username: String)
}

class FollowersListVC: UIViewController {
    
    enum Section{
        case main
    }
    
    var username:String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section,Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    @objc func addButtonTapped(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self](result) in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result{
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self](error) in
                    guard let self = self else {return}
                    guard let error = error else{
                        self.presentGFAlertOnMainThread(title: "Success", message: "You have successfuly favorited this user 🎉🎊", buttonTitle: "Yeah")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Try Again")
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        
        navigationItem.searchController = searchController
        
    }
    
    
    func getFollowers(username: String,page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else{ return }
            self.dismissLoadingView()
            switch result{
                case.success(let followers):
                    if followers.count < 100 {self.hasMoreFollowers = false}
                    self.followers.append(contentsOf:followers)
                    
                    if self.followers.isEmpty{
                        let message = "This user doesn't have any followers. Go follow them 😁."
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: message, in: self.view)
                        }
                        return
                    }
                    self.updateData(on: self.followers)
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
    
    func updateData(on follower: [Follower]){
        var snapShot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(follower)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching == true ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.delegate = self
        destVC.username = follower.login
        let navVC = UINavigationController(rootViewController: destVC)
        present(navVC, animated: true)
    }
}


extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
        
        isSearching = true
        filteredFollowers =  followers.filter{$0.login.lowercased().contains(searchText.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
    
    
}

extension FollowersListVC: FollowersListVCDelegate{
    
    func didRequestFollwer(for username: String) {
        
        self.username       = username
        self.title          = username
        page                = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)

        
    }
    
}
