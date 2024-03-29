//
//  SharePhoto.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 31.03.2022.
//

import Foundation
import Firebase

struct SharePhoto {
    let user : User
    let photoUrl : String?
    let photoHeight : Double?
    let photoWidth : Double?
    let userID : String?
    let message : String?
    let dateTime : Timestamp
    
    init(user : User,data : [String : Any]) {
        self.user = user
        self.photoUrl = data["photoUrl"] as? String
        self.photoHeight = data["photoHeight"] as? Double
        self.photoWidth = data["photoWidth"] as? Double
        self.userID = data["userID"] as? String
        self.message = data["message"] as? String
        self.dateTime = data["dateTime"] as? Timestamp ?? Timestamp(date: Date())
        
    }
}
