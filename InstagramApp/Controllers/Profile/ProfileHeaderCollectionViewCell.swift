//
//  ProfileHeaderCollectionViewCell.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 25.02.2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class ProfileHeaderCollectionViewCell: UICollectionViewCell {
    
    var currentUser : User? {
        didSet {
            guard let url = URL(string: currentUser?.userProfilePhotoUrl ?? "") else { return }
            userImage.sd_setImage(with: url, completed: nil)
        }
    }
    
    let userImage : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .yellow
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(userImage)
        let imageSize : CGFloat = 90
        userImage.anchor(top: topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: imageSize, height: imageSize)
        userImage.layer.cornerRadius =  imageSize / 2
        userImage.clipsToBounds = true
        //fetchProfilePhoto()
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    fileprivate func fetchProfilePhoto(){
//
//        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
//
//        Firestore.firestore().collection("Users").document(currentUserID).getDocument { snapshot, error in
//            if let error = error {
//                print("Kullanıcı profil resmi getirilirken hata oluştu.")
//                print("Hata Mesajı : \(error)")
//            }
//
//            guard let  userData = snapshot?.data() else { return }
//
//            guard let profilePhotoURL = userData["userProfilePhotoUrl"] as? String else { return }
//
//            print("Kullanıcı Profil Fotoğrafı URL : \(profilePhotoURL)")
//
//            guard let url = URL(string: profilePhotoURL) else { return }
//
//            self.userImage.sd_setImage(with: url, completed: nil)
//
//            /*
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error = error {
//                    print("Profil Fotoğrafı indirilemedi" , error)
//                    return
//                }
//
//                print(data)
//
//                guard let data = data else {
//                    return
//                }
//
//                let image = UIImage(data: data)
//                DispatchQueue.main.async {
//                    self.userImage.image = image
//                }
//
//            }.resume()
//            */
//        }
//
//    }
    
    
    
}
