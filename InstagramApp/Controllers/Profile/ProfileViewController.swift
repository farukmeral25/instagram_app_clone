//
//  ProfileViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 25.02.2022.
//

import UIKit
import Firebase

class ProfileViewController: UICollectionViewController {
    
    var currentUser : User?
    
    let postCellID = "postCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        //navigationItem.title = "Kullanıcı Profili"
        fetchUserData()
        collectionView.register(ProfileHeaderCollectionViewCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "headerID")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: postCellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! ProfileHeaderCollectionViewCell
        
        header.currentUser = currentUser 
        //header.backgroundColor = .green
        
        return header
    }
    
 
    
    /// Posts UI
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellID, for: indexPath)
        postCell.backgroundColor = .blue
        return postCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width - 5) / 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
    
    fileprivate func fetchUserData(){
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            return
        }
        
        Firestore.firestore().collection("Users").document(currentUserID).getDocument { snapshot, error in
            if let error = error {
                print("Kullanıcı bilgileri getirilemedi.")
                print("Hata Mesajı : \(error)")
            }
            
            guard let userData = snapshot?.data() else {
                return
            }
            
            let userName = userData["userName"] as? String
            self.currentUser = User(userData: userData)
            ///Header alanı yenilenecek.
            self.collectionView.reloadData()
            self.navigationItem.title = self.currentUser?.userName

            
            
        }
    }
    


}
