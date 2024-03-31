//
//  UIConfig.swift
//  moment
//
//  Created by Allen Wu on 29/03/2024.
//

import Foundation
import UIKit




//Config Color
func rgbColor(r: Int,g:Int,b:Int) -> UIColor{
    if #available(iOS 10.0, *){
        return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
        
    }
}


func rgbColor(rgb: Int) -> UIColor {
    return rgbColor(r: rgb, g: rgb, b: rgb)
}
