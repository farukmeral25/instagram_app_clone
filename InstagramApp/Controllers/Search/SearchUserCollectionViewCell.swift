//
//  SearchUserCollectionViewCell.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 3.04.2022.
//

import UIKit

class SearchUserCollectionViewCell: UICollectionViewCell {
    
    let userProfilePhoto : UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .yellow
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 55 / 2
        return image
    }()
    
    let labelUserName : UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(userProfilePhoto)
        addSubview(labelUserName)
        userProfilePhoto.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 55, height: 55)
        userProfilePhoto.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelUserName.anchor(top: topAnchor, bottom: bottomAnchor, leading: userProfilePhoto.trailingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: -8, width: 0, height: 0)
        
        let divider = UIView()
        divider.backgroundColor = UIColor(white: 0, alpha: 0.45)
        addSubview(divider)
        divider.anchor(top: nil, bottom: bottomAnchor, leading: labelUserName.leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.45)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
