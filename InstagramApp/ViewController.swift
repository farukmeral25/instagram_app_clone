//
//  ViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 24.02.2022.
//

import UIKit
import Firebase
import JGProgressHUD

class ViewController: UIViewController {
    
    let buttonAddPhoto : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName:"Fotograf_Sec").withRenderingMode(.alwaysOriginal) , for: .normal)
        //button.backgroundColor = .yellow
        //Auto Layout için gerekli kısıtları kabul etsin diye false yaptık.
        //button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonAddPhotoPressed), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func buttonAddPhotoPressed (){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    let textFieldEmail : UITextField = {
       let textField = UITextField()
        textField.placeholder = "E-mail adresinizi giriniz."
        //textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(white: 0, alpha: 0.05)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.addTarget(self, action: #selector(whenDataChanges), for: .editingChanged)
        return textField
    }()
    
    let textFieldUserName : UITextField = {
       let textField = UITextField()
        textField.placeholder = "Kullanıcı adınızı giriniz."
        //textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(white: 0, alpha: 0.05)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.addTarget(self, action: #selector(whenDataChanges), for: .editingChanged)
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
        textField.addTarget(self, action: #selector(whenDataChanges), for: .editingChanged)
        return textField
    }()
    
    let buttonSignUp : UIButton = {
       let button = UIButton()
        button.setTitle("Kayıt Ol ", for: .normal)
        //button.backgroundColor = UIColor(red: 150/255, green: 205/255, blue: 245/255, alpha: 1)
        button.backgroundColor = UIColor.convertRGBA(red: 150, green: 205, blue: 245)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        ///Butona onPressed methodu ekleme
        button.addTarget(self, action: #selector(buttonSignUpPressed), for: .touchUpInside)
        button.isEnabled = false
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
        let stackView = UIStackView(arrangedSubviews: [textFieldEmail,textFieldUserName,textFieldPassword,buttonSignUp])
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
    
    @objc fileprivate func buttonSignUpPressed(){
        //let email = "deneme3@gmail.com"
        //let password  = "123456"
        
        guard let email = textFieldEmail.text else { return }
        
        guard let password = textFieldPassword.text else { return }
        
        guard let userName = textFieldUserName.text else { return }
        
        let createdProfileInfoHUD = JGProgressHUD(style: .light)
        createdProfileInfoHUD.textLabel.text = "Kaydınız oluşturuluyor."
        createdProfileInfoHUD.show(in: self.view)
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Kullanıcı kayıt olurken hata meydana geldi.")
                createdProfileInfoHUD.dismiss(animated: true)
                return
            }
            
            guard let createdUserID = result?.user.uid else { return }
            
            let photoID = UUID().uuidString
            
            let ref = Storage.storage().reference(withPath: "/ProfilePhotos/\(photoID)")
            let photoData = self.buttonAddPhoto.imageView?.image?.jpegData(compressionQuality: 0.8 ) ?? Data()
            
            ref.putData(photoData, metadata: nil) { storageMetadata, error in
                if let error = error {
                    print("Fotoğraf kaydedilemedi.")
                    print("Hata Mesajı: \(error)")
                    return
                }
                
                print("Görüntü başarıyla kaydedildi.")
                
                ref.downloadURL { url, error in
                    if let error = error {
                        print("Görüntünün url adresi alınamadı.")
                        print("Hata Mesajı : \(error)")
                        return
                    }
                    
                    print("Görüntünün Url Adresi Burada Bulunmaktadır: \(url?.absoluteString ?? "Link Yok")")
                    
                    let addedData = [
                        "userName" : userName,
                        "userID" : createdUserID,
                        "userProfilePhotoUrl": url?.absoluteString ?? ""
                    ]
                    
                    Firestore.firestore().collection("Users").document(createdUserID).setData(addedData) { error in
                        if let error = error  {
                            print("Kullanıcı verileri firestore'a ekleyemedi.")
                            print("Hata Mesajı : \(error)")
                            return
                        }
                        print("Kullanıcı verileri firestore'a başarıyla ekledi.")
                        createdProfileInfoHUD.dismiss(animated: true)
                        self.clearTextFieldsAndPhoto()
                        
                        let successHud = JGProgressHUD(style: .light)
                        successHud.textLabel.text = "Kayıt Başarılı"
                        successHud.show(in: self.view)
                        successHud.dismiss(afterDelay: 2)
                        
                    }
                }
            }
            
            print("Kullanıcı kaydı başarıyla gerçekleşti.")
          
         
            
        }
    }
    
    fileprivate func clearTextFieldsAndPhoto(){
        self.buttonAddPhoto.setImage(#imageLiteral(resourceName:"Fotograf_Sec").withRenderingMode(.alwaysOriginal) , for: .normal)
        self.buttonAddPhoto.layer.borderColor = UIColor.clear.cgColor
        self.buttonAddPhoto.layer.borderWidth = 0
        self.textFieldEmail.text = ""
        self.textFieldPassword.text = ""
        self.textFieldUserName.text = ""
    }
    
    @objc fileprivate func whenDataChanges(){
        let isFormSuccess = (textFieldEmail.text?.count ?? 0) > 0 && (textFieldUserName.text?.count ?? 0) > 0 &&  (textFieldPassword.text?.count ?? 0) > 0 && ((textFieldEmail.text?.contains("@") ?? false))
        
        if isFormSuccess {
            buttonSignUp.isEnabled = true
            buttonSignUp.backgroundColor = UIColor.convertRGBA(red: 20, green: 155, blue: 235)
        }else {
            buttonSignUp.isEnabled = false
            buttonSignUp.backgroundColor = UIColor.convertRGBA(red: 150, green: 205, blue: 245)
        }
    }


}



