//
//  UIViewExtensions.swift
//  InstagramApp
//
//  Created by Ömer Faruk Meral on 24.02.2022.
//

import Foundation
import UIKit

extension UIView{
    func anchor (top: NSLayoutYAxisAnchor?,
                 bottom: NSLayoutYAxisAnchor?,
                 leading: NSLayoutXAxisAnchor?,
                 trailing: NSLayoutXAxisAnchor?,
                 paddingTop: CGFloat,
                 paddingLeft: CGFloat,
                 paddingBottom: CGFloat,
                 paddingRight:CGFloat,
                 width: CGFloat,
                 height: CGFloat
    ){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
}
