//
//  PhotoSelectorHeaderCollectionViewCell.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 28.03.2022.
//

import UIKit

class PhotoSelectorHeaderCollectionViewCell: UICollectionViewCell {
    let imageHeader : UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .darkGray
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageHeader)
        imageHeader.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
