//
//  SearchUserCollectionViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 3.04.2022.
//

import UIKit
import Firebase

class SearchUserCollectionViewController: UICollectionViewController, UISearchBarDelegate {
    
    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter username"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.convertRGBA(red: 230, green: 230, blue: 230)
        searchBar.delegate = self
        return searchBar
    }()
    
   
    
    let cellID = "cellID"
    var users = [User]()
    var filteredUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        searchBar.anchor(top: navBar?.topAnchor, bottom: navBar?.bottomAnchor, leading: navBar?.leadingAnchor, trailing: navBar?.trailingAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: -10, width: 0, height: 0)
        
        collectionView.register(SearchUserCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.alwaysBounceVertical = true
        //Ekranda sürükleme yapıldığında klavye kaldırılır.
        collectionView.keyboardDismissMode = .onDrag
        fetchUsers()
    }
    
    //Bu ekran her açıldığında yapılacak işlem
    override func viewWillAppear(_ animated: Bool) {
        searchBar.isHidden = false
    }
    
    fileprivate func fetchUsers(){
        Firestore.firestore().collection("Users").getDocuments { querySnapshot, err in
            if let err = err {
                print("Error : ", err)
            }
            
            querySnapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let user = User(userData: change.document.data())
                    if user.userID != Auth.auth().currentUser?.uid {
                        self.users.append(user)
                    }
                    
                }
            })
            
            self.users.sort { user1, user2 -> Bool in
                return user1.userName.lowercased().compare(user2.userName.lowercased()) == .orderedAscending
            }
            
            self.filteredUsers = self.users
            self.collectionView.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredUsers = users
        }else {
            self.filteredUsers = self.users.filter({ user in
                return user.userName.lowercased().contains(searchText.lowercased())
            })
        }
        
        self.collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return filteredUsers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchUserCollectionViewCell
        cell.user = filteredUsers[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.isHidden = true
        searchBar.resignFirstResponder()
        let user = filteredUsers[indexPath.row]
        let profileViewController = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        profileViewController.userID = user.userID
        
        navigationController?.pushViewController(profileViewController, animated: true)
    }

}
