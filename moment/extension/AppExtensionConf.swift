//
//  AppExtensionConf.swift
//  moment
//
//  Created by Allen Wu on 29/03/2024.
//

import Foundation
import UIKit
import CoreGraphics
import CommonCrypto



struct ScreenData{
    static var bounds:CGRect{ return UIscreen.main.bounds}
    static var width:CGFloat{ return bounds.width}
    static var height: CGFloat{ return ScreenData.bounds.height}
    
}


extension String{
    func textSize(fitWidth: CGFloat,fontSize: CGFloat) -> CGSize{
        let size = CGSize(width: fitWidth,height:CGFloat.greatestFiniteMagnitude)
        return textSize(size: size, font: UIFont.fitSize(size: fontSize))
    }
            
    func textSize(size: CGSize,font: UIFont) -> CGSize {
        let md5Key = MD5String;
        if let boundSize = RelationManager.value(key: md5Key) as? CGSize {
            return boundSize;
        }
        let bounds = NSString(string: self).boundingRect(with: size, options: [NSStringDrawingOptions.usesFontLeading,NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font:font], context: nil);
        RelationManager.setKey(key: md5Key, value: bounds.size);
        return bounds.size;
    }
    
    var MD5String: String {
        let cStrl = cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
        var md5String = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        free(buffer);
        return md5String;
    }
    
    
}



extension UIFont {
    class func fitSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize:size);
    }
}

