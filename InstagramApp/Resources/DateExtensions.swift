//
//  DateExtensions.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 6.04.2022.
//

import Foundation

extension Date {

    func calculateTime() -> String {
        
        let seconds = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let ratio : Int
        let time : String
        
        if seconds < hour {
            ratio = seconds
            time = "Seconds"
        }else if seconds < hour {
            ratio = seconds / minute
            time = "Minute"
        }else if seconds < day {
            ratio = seconds / hour
            time = "Hour"
        }else if seconds < week {
            ratio = seconds / day
            time = "Days"
        }else if seconds < month {
            ratio = seconds / week
            time = "Weeks"
        }else {
            ratio = seconds / month
            time = "Month"
        }
        
        return "\(ratio) \(time) later"
        
    }


}

