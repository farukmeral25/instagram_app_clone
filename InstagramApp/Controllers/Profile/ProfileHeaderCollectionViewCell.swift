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
            setFollowButton()
            guard let url = URL(string: currentUser?.userProfilePhotoUrl ?? "") else { return }
            userImage.sd_setImage(with: url, completed: nil)
            labelUserName.text = currentUser?.userName
        }
    }
    
    
    let userImage : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .yellow
        return image
    }()
    
    let labelPost : UILabel = {
        let label = UILabel()
        label.text = "6"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    let labelFollower : UILabel = {
        let label = UILabel()
        label.text = "362"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    let labelFollow : UILabel = {
        let label = UILabel()
        label.text = "526"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    let labelPostText : UILabel = {
        let label = UILabel()
        label.text = "Posts"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    let labelFollowerText : UILabel = {
        let label = UILabel()
        label.text = "Follower"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    let labelFollowText : UILabel = {
        let label = UILabel()
        label.text = "Follow"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    lazy var buttonEditProfile : UIButton = {
        let button = UIButton()
        
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 6
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(editButtonProfileFollow), for: .touchUpInside)
        return button
    }()
    
    fileprivate func setFollowButton(){
        guard let loggedUserID = Auth.auth().currentUser?.uid else { return }
        guard let currentUserID = currentUser?.userID else { return }
        if loggedUserID != currentUserID {
            Firestore.firestore().collection("Follow").document(loggedUserID).getDocument { snapshot, error in
                if let error = error {
                    print("Error : ", error.localizedDescription)
                    return
                }
                guard let followData = snapshot?.data() else { return }
                if let data = followData[currentUserID] {
                    let follow = data as! Int
                    print(follow)
                    if follow == 1 {
                        self.buttonEditProfile.setTitle("UnFollow", for: .normal)
                    }
                }else {
                    self.buttonEditProfile.setTitle("Follow", for: .normal)
                    self.buttonEditProfile.backgroundColor = UIColor.convertRGBA(red: 20, green: 155, blue: 240)
                    self.buttonEditProfile.setTitleColor(.white, for: .normal)
                    self.buttonEditProfile.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
                    self.buttonEditProfile.layer.borderWidth = 1
                }
            }
           
        } else {
            self.buttonEditProfile.setTitle("Edit Profile", for: .normal)
        }
    }

    
    @objc fileprivate func editButtonProfileFollow(){
        guard let loggedUserID = Auth.auth().currentUser?.uid else { return }
        guard let currentUserID = currentUser?.userID else { return }
        
        if buttonEditProfile.titleLabel?.text == "UnFollow" {
            Firestore.firestore().collection("Follow").document(loggedUserID).updateData([currentUserID : FieldValue.delete()]) { error in
                if let error = error {
                    print("Error : ", error)
                    return
                }
                print("\(self.currentUser?.userName ?? "") unFollow")
                self.buttonEditProfile.backgroundColor = UIColor.convertRGBA(red: 20, green: 155, blue: 240)
                self.buttonEditProfile.setTitle("Follow", for: .normal)
                self.buttonEditProfile.setTitleColor(.white, for: .normal)
                self.buttonEditProfile.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
                self.buttonEditProfile.layer.borderWidth = 1
            }
            return
        }
        
        
        let addedValue = [currentUserID : 1]
        
        Firestore.firestore().collection("Follow").document(loggedUserID).getDocument { snapshot, error in
            if let error = error {
                print("Error : ", error.localizedDescription)
            }
            if snapshot?.exists == true {
                Firestore.firestore().collection("Follow").document(loggedUserID).updateData(addedValue) { error in
                    if let error = error {
                        print("Error : ", error.localizedDescription)
                        return
                    }
                    self.buttonEditProfile.setTitle("UnFollow", for: .normal)
                    self.buttonEditProfile.setTitleColor(.black, for: .normal)
                    self.buttonEditProfile.backgroundColor = .white
                    self.buttonEditProfile.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                    self.buttonEditProfile.layer.borderColor = UIColor.lightGray.cgColor
                    self.buttonEditProfile.layer.borderWidth = 1
                    self.buttonEditProfile.layer.cornerRadius = 5
                    print("Success following")
                }
            }else {
                Firestore.firestore().collection("Follow").document(loggedUserID).setData(addedValue) { error in
                    print("Error : ", error?.localizedDescription)
                    return
                }
                self.buttonEditProfile.setTitle("UnFollow", for: .normal)
                self.buttonEditProfile.setTitleColor(.black, for: .normal)
                self.buttonEditProfile.backgroundColor = .white
                self.buttonEditProfile.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                self.buttonEditProfile.layer.borderColor = UIColor.lightGray.cgColor
                self.buttonEditProfile.layer.borderWidth = 1
                self.buttonEditProfile.layer.cornerRadius = 5
                print("Success following")
            }
        }
        
       
        
    }
    
    let labelUserName : UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    let buttonGridView : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Izgara"), for: .normal)
        return button
    }()
    
    let buttonList : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Liste"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let buttonBookmark : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Yer_Isareti"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .red
        addSubview(userImage)
        let imageSize : CGFloat = 90
        userImage.anchor(top: topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: imageSize, height: imageSize)
        userImage.layer.cornerRadius =  imageSize / 2
        userImage.clipsToBounds = true
        //fetchProfilePhoto()
        createToolbar()
        addSubview(labelUserName)
        labelUserName.anchor(top: userImage.bottomAnchor, bottom: buttonGridView.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop:  5, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        showUserInfo()
        addSubview(buttonEditProfile)
        buttonEditProfile.anchor(top: labelPostText.bottomAnchor, bottom: nil, leading: labelPostText.leadingAnchor, trailing: labelFollow.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 35)
        
    }
    
    fileprivate func createToolbar(){
        
        let topDivider = UIView()
        topDivider.backgroundColor = UIColor.lightGray
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = UIColor.lightGray
        let stackView = UIStackView(arrangedSubviews: [buttonGridView,buttonList,buttonBookmark])
        
        
        addSubview(stackView)
        addSubview(topDivider)
        addSubview(bottomDivider)
        
        stackView.axis = .horizontal
        //Bütün nesnelerin eşit oranda yer kaplamasını sağlayan parametre
        stackView.distribution = .fillEqually
        topDivider.anchor(top: stackView.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        stackView.anchor(top: nil, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        bottomDivider.anchor(top: stackView.bottomAnchor, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    fileprivate func showUserInfo(){
        let stackView = UIStackView(arrangedSubviews: [labelPost,labelFollower,labelFollow])
        let stackViewText = UIStackView(arrangedSubviews: [labelPostText,labelFollowerText,labelFollowText])
        addSubview(stackView)
        addSubview(stackViewText)
        stackViewText.distribution = .fillEqually
        stackView.distribution = .fillEqually
        
        stackView.anchor(top: topAnchor, bottom: nil, leading: userImage.trailingAnchor, trailing: trailingAnchor, paddingTop: 15, paddingLeft: 50, paddingBottom: 0, paddingRight: -15, width: 0, height: 50)
        
        stackViewText.anchor(top: stackView.topAnchor, bottom: nil, leading: userImage.trailingAnchor, trailing: trailingAnchor, paddingTop: 30, paddingLeft: 50, paddingBottom: 0, paddingRight: -15, width: 0, height: 50)
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
