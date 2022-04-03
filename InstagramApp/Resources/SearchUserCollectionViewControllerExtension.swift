//
//  SearchUserCollectionViewControllerExtension.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 3.04.2022.
//

import Foundation
import UIKit

extension SearchUserCollectionViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
}
