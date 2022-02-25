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

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        //navigationItem.title = "Kullanıcı Profili"
        fetchUserData()
        collectionView.register(ProfileHeaderCollectionViewCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "headerID")
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! ProfileHeaderCollectionViewCell
        header.currentUser = currentUser 
        //header.backgroundColor = .green
        
        return header
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
