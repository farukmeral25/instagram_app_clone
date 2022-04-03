//
//  HomeCollectionViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 2.04.2022.
//

import UIKit
import Firebase

class HomeCollectionViewController: UICollectionViewController {
    
    let cellID = "cellID"
    var shares = [SharePhoto]()
    var currentUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(HomeShareCollectionViewCell.self, forCellWithReuseIdentifier: cellID)

        // Do any additional setup after loading the view.
        
        createButtons()
        fetchUser()
    }

    fileprivate func getSharePhotos(){
        shares.removeAll()
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        guard let currentUser = currentUser else {
            return
        }

        Firestore.firestore().collection("Shares").document(currentUserID).collection("SharePhotos").order(by: "dateTime", descending: false).addSnapshotListener { querySnapshot, err in
            if let err = err {
                print("Error : ", err.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let shareData = change.document.data()
                    let share = SharePhoto(user: currentUser, data: shareData)
                    self.shares.append(share)
                }
            })
            self.shares.reverse()
            self.collectionView.reloadData()
        }
        
        
    }
    
    fileprivate func createButtons() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "Logo_Instagram2"))
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return shares.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomeShareCollectionViewCell
        
        cell.share = shares[indexPath.row]
        
        return cell
    }
    
    fileprivate func fetchUser() {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("Users").document(currentUserID).getDocument { snapshot, err in
            if let err = err {
                print("Error : ", err)
            }
            
            guard let userData = snapshot?.data() else { return }
            
            self.currentUser = User(userData: userData)
            self.getSharePhotos()
        }
    }
    
    
}

