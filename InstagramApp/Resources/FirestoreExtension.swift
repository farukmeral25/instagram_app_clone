//
//  FirestoreExtension.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 6.04.2022.
//

import Foundation

import Firebase

extension Firestore {
    static func createUser(userID : String = "",completion : @escaping (User) -> ()){
        var uid = ""
        if userID == "" {
            guard let currentUserID = Auth.auth().currentUser?.uid else { return }
            uid = currentUserID
        }else {
            uid = userID
        }
        
        Firestore.firestore().collection("Users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Error : ", error.localizedDescription)
                return
            }
            
            guard let userData = snapshot?.data() else { return }
            
            let user = User(userData: userData)
            completion(user)
        }
    }
}

