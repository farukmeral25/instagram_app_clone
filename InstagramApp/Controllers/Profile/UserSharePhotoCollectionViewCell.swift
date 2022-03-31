//
//  UserSharePhotosCollectionViewCell.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 31.03.2022.
//

import UIKit

class UserSharePhotoCollectionViewCell: UICollectionViewCell {
    var share: SharePhoto? {
        didSet {
            print("Hücre oluşturuldu.")
            if let url = URL(string: share?.photoUrl ?? ""){
                sharePhoto.sd_setImage(with: url,completed: nil)
            }
            
        }
    }
    let sharePhoto : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sharePhoto)
        sharePhoto.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
