//
//  ChoosePhotoCollectionVievControllerExtensions.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 4.03.2022.
//

import Foundation
import UIKit

extension ChoosePhotoCollectionViewController: UICollectionViewDelegateFlowLayout{
    //Sayfa da bulunan her hücrenin kaplayacağı alan için gerekli olan method burada bulunmaktadır.
    //Delegate olması gerekmektedir.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4 
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 1
    }
}
