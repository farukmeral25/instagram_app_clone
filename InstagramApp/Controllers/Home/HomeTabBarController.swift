//
//  HomeTabBarController.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 25.02.2022.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .blue
        
        let layout = UICollectionViewFlowLayout()
        let profileViewController = ProfileViewController(collectionViewLayout: layout)
        let navigationController = UINavigationController(rootViewController: profileViewController)
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "Profil")
        navigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "Profil_Secili")
        tabBar.tintColor = .black
        
        viewControllers = [navigationController,UIViewController()]
        
    }
    

    

}
