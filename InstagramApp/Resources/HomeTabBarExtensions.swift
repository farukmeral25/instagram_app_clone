//
//  HomeTabBarExtensions.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 4.03.2022.
//

import Foundation
import UIKit

extension HomeTabBarController :  UITabBarControllerDelegate {
    
    
    //Basılan viewcontroller gösterilsin mi gösterilmesin mi methodu
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let index = viewControllers?.firstIndex(of: viewController) else { return true }
        if index == 2 {
            //Index 2 iken gideceği sayfanın navigation işlemi
            let layout = UICollectionViewFlowLayout()
            let choosePhotoController = ChoosePhotoCollectionViewController(collectionViewLayout: layout)
            let navigationController = UINavigationController(rootViewController: choosePhotoController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
            
            return false
        }
        print("\(index). butona bastın.")
        
        return true
    }
    
}
