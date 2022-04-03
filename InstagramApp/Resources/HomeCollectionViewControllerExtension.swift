//
//  HomeCollectionViewControllerExtension.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 2.04.2022.
//

import Foundation
import UIKit


extension HomeCollectionViewController : UICollectionViewDelegateFlowLayout{
    
    
    ///Hücrelerin boyutları bu method ile verilir.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height : CGFloat = 55
        height = height + view.frame.width
        height = height + 50
        height = height + 70
        return CGSize(width: view.frame.width, height: height)
    }
}
