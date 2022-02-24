//
//  ViewControllerExtensions.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 24.02.2022.
//

import Foundation
import UIKit

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        self.buttonAddPhoto.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        ///Gelen fotoğrafa radius verildi.
        buttonAddPhoto.layer.cornerRadius = buttonAddPhoto.frame.width / 2
        ///Gelen fotoğrafın sınırlarını göstermemek için kullanılan parametre
        buttonAddPhoto.layer.masksToBounds = true
        buttonAddPhoto.layer.borderColor = UIColor.darkGray.cgColor
        buttonAddPhoto.layer.borderWidth = 3
        dismiss(animated: true , completion: nil)
     }
}

