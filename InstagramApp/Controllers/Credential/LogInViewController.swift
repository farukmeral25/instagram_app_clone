//
//  LogInViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 1.03.2022.
//

import UIKit

class LogInViewController: UIViewController {

    let buttonSignUp : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(buttonSignUpPressed), for: .touchUpInside)
        return button
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(buttonSignUp)
        buttonSignUp.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        view.backgroundColor = .white
    }
    
    ///Bu method kayıt ol sayfasına gidiyor.
    @objc fileprivate func buttonSignUpPressed(){
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true )
    }
    

  

}
