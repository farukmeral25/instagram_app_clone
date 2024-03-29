//
//  ProfileViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 25.02.2022.
//

import UIKit
import Firebase

class ProfileViewController: UICollectionViewController {
    
    var userID : String?
    
    var currentUser : User?
    
    let postCellID = "postCellID"
    
    var shares = [SharePhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        //navigationItem.title = "Kullanıcı Profili"
        fetchUserData()
        collectionView.register(ProfileHeaderCollectionViewCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "headerID")
        collectionView.register(UserSharePhotoCollectionViewCell.self, forCellWithReuseIdentifier: postCellID)
        createLogOutButton()
        
    }
    
    fileprivate func fetchSharePhotos() {
        //guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        guard let currentUserID = self.currentUser?.userID else { return }
        guard let currentUser = currentUser else {
            return
        }

        Firestore.firestore().collection("Shares").document(currentUserID).collection("SharePhotos").order(by: "dateTime", descending: false).addSnapshotListener { querySnapshot, err in
            if let err = err{
                print("Error: ", err)
            }
            querySnapshot?.documentChanges.forEach({ modification in
                if modification.type == .added {
                    //Döküman verisine ulaşma
                    let shareData = modification.document.data()
                    let share = SharePhoto(user: currentUser, data: shareData)
                    self.shares.append(share)
                }
            })
            self.shares.reverse()
            //Tüm paylaşımlar shares dizisine aktarıldı.
            self.collectionView.reloadData()
        }
    }
 
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! ProfileHeaderCollectionViewCell
        
        //Header'da bulunan currentUser parametresine burada bulunan currentUser atanması yapıldı.
        header.currentUser = currentUser 
        //header.backgroundColor = .green
        
        return header
    }
    
    ///Geçerli kullanıcının hesaptan çıkış yapmasını sağlayan method
    @objc func logOut (){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionLogOut = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            guard let _ = Auth.auth().currentUser?.uid else {
                return
            }
            
            do {
                try Auth.auth().signOut()
                let logInController = LogInViewController()
                let navigationController = UINavigationController(rootViewController: logInController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            } catch let logOutError{
                print("Log Out Error: \(logOutError)")
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Oturum kapatma işlemi iptal edildi.")
        }
        alertController.addAction(actionLogOut)
        alertController.addAction(actionCancel)
        present(alertController, animated: true, completion: nil)
    }
 
    
    // Posts UI Start
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shares.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellID, for: indexPath) as! UserSharePhotoCollectionViewCell
        postCell.share = shares[indexPath.row]
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
    
    // Posts UI End
    
    fileprivate func fetchUserData(){
        /*guard let currentUserID = Auth.auth().currentUser?.uid else {
            return
        }
         */
        
        let currentUserID = userID ?? Auth.auth().currentUser?.uid ?? ""
        
        Firestore.firestore().collection("Users").document(currentUserID).getDocument { snapshot, error in
            if let error = error {
                print("Kullanıcı bilgileri getirilemedi.")
                print("Hata Mesajı : \(error)")
            }
            
            guard let userData = snapshot?.data() else {
                return
            }
            
            //let userName = userData["userName"] as? String
            self.currentUser = User(userData: userData)
            ///Header alanı yenilenecek.
            //self.collectionView.reloadData()
            self.fetchSharePhotos()
            self.navigationItem.title = self.currentUser?.userName

            
            
        }
    }
    
    ///Log Out butonu oluşturuluyor. Basıldığında alınacak aksiyon logout methodu.
    fileprivate func createLogOutButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Ayarlar").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(logOut))
    }
    
    


}
