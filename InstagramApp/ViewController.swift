//
//  ViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 24.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let buttonAddPhoto : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName:"Fotograf_Sec").withRenderingMode(.alwaysOriginal) , for: .normal)
        //button.backgroundColor = .yellow
        //Auto Layout için gerekli kısıtları kabul etsin diye false yaptık.
        //button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let textFieldEmail : UITextField = {
       let textField = UITextField()
        textField.placeholder = "E-mail adresinizi giriniz."
        //textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(white: 0, alpha: 0.05)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    let textFieldUserName : UITextField = {
       let textField = UITextField()
        textField.placeholder = "KUllanıcı adınızı giriniz."
        //textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(white: 0, alpha: 0.05)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    let textFieldPassword : UITextField = {
       let textField = UITextField()
        textField.placeholder = "Parola giriniz."
        textField.isSecureTextEntry = true
        //textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(white: 0, alpha: 0.05)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    let buttonSignIn : UIButton = {
       let button = UIButton()
        button.setTitle("Kayıt Ol ", for: .normal)
        //button.backgroundColor = UIColor(red: 150/255, green: 205/255, blue: 245/255, alpha: 1)
        button.backgroundColor = UIColor.convertRGBA(red: 150, green: 205, blue: 245)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //View'da görünmesini sağlayan method
        view.addSubview(buttonAddPhoto)
        ///Frame özelliği bir nesneyi hemen konumlandırmak için kullanılır ve kalıcıdır.
        //buttonAddPhoto.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        ///Button ekranın merkezinde görünecek.
        //buttonAddPhoto.center = view.center
        //buttonAddPhoto.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //buttonAddPhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
        buttonAddPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //buttonAddPhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        buttonAddPhoto.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        createInputField()
        
   
        
       
    }
    
    fileprivate func createInputField(){
        let stackView = UIStackView(arrangedSubviews: [textFieldEmail,textFieldUserName,textFieldPassword,buttonSignIn])
        //stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: buttonAddPhoto.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingLeft: 45, paddingBottom: 0, paddingRight: -45,width: 0,height: 230)
        /*
        NSLayoutConstraint.activate([
            ///Herhangi bir widgetla bağlantılı olduğu durumda equalTo, constant kullanılıyor.
            
            //stackView.topAnchor.constraint(equalTo: buttonAddPhoto.bottomAnchor, constant: 20),
            //stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            //stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            ///Yanlızca widgetı ilgilendiren bir durumda equalToConstant
            //stackView.heightAnchor.constraint(equalToConstant: 230)
        ])
        */
        
        
        
        
    }


}

