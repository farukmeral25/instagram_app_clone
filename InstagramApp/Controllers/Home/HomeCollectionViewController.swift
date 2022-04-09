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
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshShareData), name: SharePhotoViewController.updateNotification, object: nil)
        collectionView.backgroundColor = .white
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(HomeShareCollectionViewCell.self, forCellWithReuseIdentifier: cellID)

        // Do any additional setup after loading the view.
        
        createButtons()
        fetchUser() //Oturumu açmış olan kullanıcının paylaşımları getiriliyor.
        //fetchUser(userID: "uen1A3xBOngDyigf1WozCARfh5U2")
        /*Firestore.createUser(userID: "uen1A3xBOngDyigf1WozCARfh5U2") { user in
            self.getSharePhotos(user: user)
        }*/
        fetchFollowedUser()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshShareData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }

    @objc
    fileprivate func refreshShareData() {
        print("Paylaşım Yenile")
        shares.removeAll()
        collectionView.reloadData()
        fetchFollowedUser()
        fetchUser()
         
    }
    
    fileprivate func fetchFollowedUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("Follow").document(uid).addSnapshotListener { documentSnapshot, error in
        
            if let error = error {
                print("Error : ", error.localizedDescription)
                return
            }
          
            guard let shareDictionaryData = documentSnapshot?.data() else { return }
            shareDictionaryData.forEach { key, value in
                Firestore.createUser(userID: key) { user in
                    self.getSharePhotos(user: user)
                }
            }
        }
        
        
    }

    fileprivate func getSharePhotos(user : User){

        Firestore.firestore().collection("Shares").document(user.userID).collection("SharePhotos").order(by: "dateTime", descending: false).addSnapshotListener { querySnapshot, err in
            self.collectionView.refreshControl?.endRefreshing()
            if let err = err {
                print("Error : ", err.localizedDescription)
                return
            }
            querySnapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let shareData = change.document.data()
                    let share = SharePhoto(user: user, data: shareData)
                    self.shares.append(share)
                }
            })
            self.shares.reverse()
            self.shares.sort { photo1, photo2 in
                return photo1.dateTime.dateValue().compare(photo2.dateTime.dateValue()) == .orderedDescending
            }
            self.collectionView.reloadData()
        }
        
        
    }
    
    fileprivate func createButtons() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "Logo_Instagram2"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Kamera").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(manageCamera))
    }
    
    
    @objc fileprivate func manageCamera() {
        let cameraController = StoryViewController()
        cameraController.modalPresentationStyle = .fullScreen
        present(cameraController, animated: true, completion: nil)
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
    
    fileprivate func fetchUser(userID : String = "") {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        let uid = userID == "" ? currentUserID : userID
        
        Firestore.firestore().collection("Users").document(uid).getDocument { snapshot, err in
            if let err = err {
                print("Error : ", err)
            }
            
            guard let userData = snapshot?.data() else { return }
            
            self.currentUser = User(userData: userData)
            guard let currentUser = self.currentUser else {
                return
            }

            self.getSharePhotos(user: currentUser)
        }
    }
    
    
}

