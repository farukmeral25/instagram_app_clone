//
//  ChoosePhotoCollectionViewCell.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 12.03.2022.
//

import UIKit

class ChoosePhotoCollectionViewCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(imageView)
        imageView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
