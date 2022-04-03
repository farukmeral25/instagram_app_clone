//
//  HomeShareCollectionViewCell.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 2.04.2022.
//

import UIKit

class HomeShareCollectionViewCell: UICollectionViewCell {
    
    let sharePhoto : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    var share : SharePhoto? {
        didSet {
            guard let url = share?.photoUrl
            , let photoUrl = URL(string: url) else { return }
            sharePhoto.sd_setImage(with: photoUrl, completed: nil)
            labelUserName.text = share?.user.userName
            guard let profileUrl = share?.user.userProfilePhotoUrl,
                  let profilePhotoUrl = URL(string: profileUrl) else { return }
            userProfilePhoto.sd_setImage(with: profilePhotoUrl,completed: nil)
            createAttrShareMessage()
        }
    }
   
    
    let userProfilePhoto : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .blue
        return image
    }()
    
    let labelUserName : UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let buttonOptions : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let buttonLike : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Begeni_Secili_Degil").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let buttonComment : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Yorum").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
   
    let buttonSendMessage : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Gonder").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
     let buttonBookmark : UIButton = {
         let button = UIButton(type: .system)
         button.setImage(#imageLiteral(resourceName: "Yer_Isareti").withRenderingMode(.alwaysOriginal), for: .normal)
         return button
     }()

    let labelSharedMessage : UILabel = {
        let label = UILabel()
        
        
        
        label.numberOfLines = 0
        
        return label
        
    }()
    
    
    fileprivate func createAttrShareMessage(){
        guard let share = share else {
            return
        }

        let attrText = NSMutableAttributedString(string: share.user.userName, attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])

        attrText.append(NSAttributedString(string: " \(share.message ?? "")", attributes: [.font: UIFont.systemFont(ofSize: 14)]))

        attrText.append(NSAttributedString(string: "\n\n", attributes: [.font: UIFont.systemFont(ofSize: 4)]))

        attrText.append(NSAttributedString(string: "1 week ago", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor : UIColor.gray]))

        labelSharedMessage.attributedText = attrText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(userProfilePhoto)
        addSubview(labelUserName)
        addSubview(sharePhoto)
        addSubview(buttonOptions)
        addSubview(labelSharedMessage)
        userProfilePhoto.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        userProfilePhoto.layer.cornerRadius = 20
        
        sharePhoto.anchor(top: userProfilePhoto.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:  0, height: 0)
        
        buttonOptions.anchor(top: topAnchor, bottom: sharePhoto.topAnchor, leading: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 45, height: 0)
        
        labelUserName.anchor(top: topAnchor, bottom: sharePhoto.topAnchor, leading: userProfilePhoto.trailingAnchor, trailing: buttonOptions.leadingAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        sharePhoto.heightAnchor.constraint(equalTo: widthAnchor ,multiplier: 1).isActive = true
        
        createInteractionButtons()
        
        labelSharedMessage.anchor(top: buttonLike.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: -8, width: 0, height: 0)
        
       
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func createInteractionButtons(){
        let stackView = UIStackView(arrangedSubviews: [buttonLike,buttonComment,buttonSendMessage])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: sharePhoto.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
        addSubview(buttonBookmark)
        buttonBookmark.anchor(top: sharePhoto.bottomAnchor, bottom: nil, leading: nil, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 40, height: 50)
    }
    
    
}
