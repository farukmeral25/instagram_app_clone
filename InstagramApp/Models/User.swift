//
//  User.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 25.02.2022.
//

import Foundation

struct User {
    let userName : String
    let userID : String
    let userProfilePhotoUrl : String
    
    init(userData : [String : Any]) {
        self.userName = userData["userName"] as? String ?? ""
        self.userID = userData["userID"] as? String ?? ""
        self.userProfilePhotoUrl = userData["userProfilePhotoUrl"] as? String ?? ""
    }
}
