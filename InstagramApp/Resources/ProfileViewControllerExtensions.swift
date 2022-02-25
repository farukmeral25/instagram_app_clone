//
//  ProfileViewControllerExtensions.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 25.02.2022.
//

import Foundation
import UIKit

extension ProfileViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(
            width: view.frame.width, height: 200)
    }
    
    
}
