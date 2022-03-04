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
        let homeNavigationController = createNavigationController(image: #imageLiteral(resourceName: "Ana_Ekran_Secili_Degil"),selectedImage: #imageLiteral(resourceName: "Ana_Ekran_Secili"), rootViewController: ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        let searchNavigationController = createNavigationController(image: #imageLiteral(resourceName: "Ara_Secili_Degil"),selectedImage: #imageLiteral(resourceName: "Ara_Secili"))
        let addNavigationController = createNavigationController(image: #imageLiteral(resourceName: "Ekle_Secili_Degil"),selectedImage: #imageLiteral(resourceName: "Ekle_Secili_Degil"))
        let likeNavigationController = createNavigationController(image: #imageLiteral(resourceName: "Begeni_Secili_Degil"),selectedImage: #imageLiteral(resourceName: "Begeni_Secili"))
        
        let layout = UICollectionViewFlowLayout()
        let profileViewController = ProfileViewController(collectionViewLayout: layout)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Profil")
        profileNavigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "Profil_Secili")
        tabBar.tintColor = .black
        
        //Tabbar da basıldığında gidilecek viewlar
        viewControllers = [homeNavigationController,searchNavigationController,addNavigationController,likeNavigationController,profileNavigationController]
        
        guard let items = tabBar.items else {
             return
        }
        //Tab Bar arka plan renklendirme
        //tabBar.backgroundColor = .red
        //Tab ile iconlar arasına boşluk verme
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
    }

    fileprivate func createNavigationController(image:UIImage, selectedImage:UIImage,rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let rootViewController = rootViewController
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.selectedImage = selectedImage
        return navigationController
    }

}
