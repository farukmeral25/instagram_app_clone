//
//  SharePhotoViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 30.03.2022.
//

import UIKit
import JGProgressHUD
import Firebase
class SharePhotoViewController: UIViewController {
    static let updateNotification = Notification.Name("ShareUpdate")
    var selectedPhoto: UIImage? {
        didSet{
            self.sharedImage.image = selectedPhoto
        }
    }
    
    let sharedImage : UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let textViewMessage: UITextView  = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 15)
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.convertRGBA(red: 240, green: 240, blue: 240)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(buttonSharePressed))
        createPhotoMessageField()
    }
    
    
    fileprivate func createPhotoMessageField(){
        let shareView = UIView()
        shareView.backgroundColor = .white
        view.addSubview(shareView)
        shareView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 120)
        
        view.addSubview(sharedImage)
        sharedImage.anchor(top: shareView.topAnchor, bottom: shareView.bottomAnchor, leading: shareView.leadingAnchor, trailing: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: -8, paddingRight: 0, width: 85, height: 0)
        view.addSubview(textViewMessage)
        textViewMessage.anchor(top: shareView.topAnchor, bottom: shareView.bottomAnchor, leading: sharedImage.trailingAnchor, trailing: shareView.trailingAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc fileprivate func buttonSharePressed(){
        navigationItem.rightBarButtonItem?.isEnabled = false
        let hud =  JGProgressHUD(style: .light)
        hud.textLabel.text = "Sharing is loading"
        hud.show(in: self.view)
        
        let photoName = UUID().uuidString
        guard let sharedPhoto = selectedPhoto else { return }
        let photoData = sharedPhoto.jpegData(compressionQuality: 0.8) ?? Data()
        
        let ref = Storage.storage().reference(withPath: "/sharePhotos/\(photoName)")
        
        ref.putData(photoData, metadata: nil) { _, err in
            if let err = err{
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Photo could not be saved : " , err)
                hud.textLabel.text = "Photo could not be saved"
                hud.dismiss(afterDelay: 2)
                return
            }
            
            
            ref.downloadURL { url, err in
                hud.textLabel.text = "Photo Saved"
                hud.dismiss(afterDelay: 2)
                if let err = err{
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    print("Could not get the url of the photo: ", err)
                    return
                }
                
                print("Url of the uploaded photo: \(url?.absoluteString)")
                if let url = url{
                    self.saveShareFireStore(photoUrl: url.absoluteString)
                }
            }
            
        }
    }
    
    fileprivate func saveShareFireStore(photoUrl : String){
        guard let sharedPhoto = selectedPhoto else { return }
        guard let message = textViewMessage.text,
              message.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else { return }
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        let addedData = ["userID" : currentUserId,
                         "photoUrl" : photoUrl,
                         "message" : message,
                         "photoWidth" :sharedPhoto.size.width,
                         "photoHeight" :sharedPhoto.size.height,
                         "dateTime" : Timestamp(date: .now)
        ] as [String: Any]
        var ref : DocumentReference? = nil
        ref = Firestore.firestore().collection("Shares").document(currentUserId).collection("SharePhotos").addDocument(data: addedData,completion: { err in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Error occurred while saving share ", err)
            }
            print("The share has been successfully saved.")
            print("Share Document ID: \(ref?.documentID)")
            self.dismiss(animated: true,completion: nil)
            
            NotificationCenter.default.post(name: SharePhotoViewController.updateNotification, object: nil)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
