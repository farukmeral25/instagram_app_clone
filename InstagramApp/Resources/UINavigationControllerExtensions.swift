//
//  UINavigationControllerExtensions.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 4.03.2022.
//

import Foundation
import UIKit

extension UINavigationController{
    
    //Status Bar gizlemek için kullanılması gereken extension
    open override var childForStatusBarHidden: UIViewController?{
        return self.topViewController
    }
}
