//
//  Extensions.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 24.02.2022.
//

import Foundation
import UIKit

extension UIColor {
    static func convertRGBA (red : CGFloat, green: CGFloat, blue : CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
