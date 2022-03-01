//
//  LogInViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 1.03.2022.
//

import UIKit
import Firebase
import JGProgressHUD

class LogInViewController: UIViewController {
    
    let logoView : UIView = {
        let view = UIView()
        let imageLogo = UIImageView(image: #imageLiteral(resourceName: "Logo_Instagram"))
        view.addSubview(imageLogo)
        imageLogo.contentMode = .scaleAspectFill
        imageLogo.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        imageLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor.convertRGBA(red: 0, green: 120, blue: 175)
        return view
    }()
    
    let textFieldEmail : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email address"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.05)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.addTarget(self, action: #selector(whenDataChanges), for: .editingChanged)
        return textField
    }()
    
    let textFieldPassword : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 0, alpha: 0.05)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.addTarget(self, action: #selector(whenDataChanges), for: .editingChanged)
        return textField
    }()
    
    let buttonLogIn : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor.convertRGBA(red: 150, green: 205, blue: 245)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(buttonLogInPressed), for: .touchUpInside)
        return button
    }()
    
    let buttonSignUp : UIButton = {
        let button = UIButton(type: .system)
        //button.setTitle("Don't have an account? Sign up", for: .normal)
        let attrTitle = NSMutableAttributedString(string: "Don't have an account?", attributes: [.font : UIFont.systemFont(ofSize: 16),
                                                                                        .foregroundColor : UIColor.lightGray])
        attrTitle.append(NSAttributedString(string: " Sign Up", attributes: [.font : UIFont.boldSystemFont(ofSize: 16),
                                                                                               .foregroundColor : UIColor.convertRGBA(red: 20, green: 155, blue: 235)
                                                                                              ]))
        button.setAttributedTitle(attrTitle, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(buttonSignUpPressed), for: .touchUpInside)
        return button
    }()
    
    //Saat, şarj, wifi iconunun rengini değiştirmek için kullanılan method
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(buttonSignUp)
        buttonSignUp.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        view.addSubview(logoView)
        logoView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop:  0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        createLogInUI()
    }
    
    ///Bu methodta log in UI bilgilerine ulaşılır.
    fileprivate func createLogInUI(){
        let stackView = UIStackView(arrangedSubviews: [textFieldEmail,textFieldPassword,buttonLogIn])
        view.addSubview(stackView)
        stackView.anchor(top: logoView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: -40, width: 0, height: 185)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
    }
    
    @objc fileprivate func whenDataChanges(){
        let isFormSuccess = (textFieldEmail.text?.count ?? 0) > 0 && (textFieldPassword.text?.count ?? 0) > 0 && ((textFieldEmail.text?.contains("@") ?? false))
        if isFormSuccess {
            buttonLogIn.isEnabled = true
            buttonLogIn.backgroundColor = UIColor.convertRGBA(red: 20, green: 155, blue: 235)
        }else {
            buttonLogIn.isEnabled = false
            buttonLogIn.backgroundColor = UIColor.convertRGBA(red: 150, green: 205, blue: 245)
        }
    }
        
    ///LogIn işlemi yapıldığında çalışacak method
    @objc fileprivate func buttonLogInPressed(){
        guard let emailAddress = textFieldEmail.text, let password = textFieldPassword.text else {
            return
        }
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Logging On"
        hud.show(in: self.view)
        
        Auth.auth().signIn(withEmail: emailAddress, password: password) { data, error in
            if let error = error {
                
                hud.dismiss(animated: true)
                let errorHud = JGProgressHUD(style: .light)
                errorHud.textLabel.text = "Error logging in: \(error.localizedDescription)"
                errorHud.show(in: self.view)
                errorHud.dismiss(afterDelay: 2)
                return
            }
            
            let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
            
            guard let homeTabBarController = keyWindow?.rootViewController as? HomeTabBarController else { return }
            homeTabBarController.createView() // Kullanıcı profil controller'a gider.
            self.dismiss(animated: true, completion: nil) // Oturum açma ekranı kapatılacak.
            
            hud.dismiss(animated: true)
            let successHud = JGProgressHUD(style: .light)
            successHud.textLabel.text = "Login successful"
            successHud.show(in: self.view)
            successHud.dismiss(afterDelay: 1)
            
        }
        
    }

    
    ///Bu method kayıt ol sayfasına gidiyor.
    @objc fileprivate func buttonSignUpPressed(){
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true )
    }
    
   
  

}
