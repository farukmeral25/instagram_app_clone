//
//  HomeTabBarController.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 25.02.2022.
//

import UIKit
import Firebase

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .blue
        
        if Auth.auth().currentUser == nil {
            //Oturum Kapalı
            print("Oturumu açan kullanıcı yok.")
            DispatchQueue.main.async {
                let loginViewController = LogInViewController()
                let navigationController = UINavigationController(rootViewController: loginViewController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
            
            return
        }
        
       createView()
        
    }
    
    func createView (){
        let layout = UICollectionViewFlowLayout()
        let profileViewController = ProfileViewController(collectionViewLayout: layout)
        let navigationController = UINavigationController(rootViewController: profileViewController)
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "Profil")
        navigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "Profil_Secili")
        tabBar.tintColor = .black
        
        viewControllers = [navigationController,UIViewController()]
    }

    

}
