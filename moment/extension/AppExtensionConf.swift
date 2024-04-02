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
    static var bounds:CGRect{ return UIScreen.main.bounds}
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


extension UIColor {
    convenience init(hexString: String) {
        
        assert(hexString.count > 5, "这不是一个十六进制的字符串: \(hexString)")
        
        var subHex = hexString;
        if hexString.count > 6 {
            subHex = String(hexString[hexString.index(after: hexString.index(hexString.endIndex, offsetBy: -7))...]);
        }
        let scanner = Scanner(string: subHex);
        var rgbValue: UInt64 = 0;
        scanner.scanHexInt64(&rgbValue);
        let r = (rgbValue & 0xff0000) >> 16;
        let g = (rgbValue & 0xff00) >> 8;
        let b = (rgbValue & 0xff);
        
        if #available(iOS 10.0, *) {
            self.init(displayP3Red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
        } else {
            // Fallback on earlier versions
            self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1);
        };
    }
    
    class var random: UIColor {
        let color = rgbColor(r: Int(arc4random_uniform(255)), g: Int(arc4random_uniform(255)), b: Int(arc4random_uniform(255)));
        return color;
    }
    
}


extension UIImage {
    
    
    
    
}


extension NotificationCenter{
    
    static func add(observer: Any,selector:Selector,name:NotificationNameDelegate){
        NotificationCenter.default.addObserver(observer, selector: selector, name: name.customName, object: nil);
    }
    
    
    
    
    static func addTo<T: NotificationActionDelegate>(observer: T,name: NotificationNameDelegate) -> Void {
        let selector = NSSelectorFromString("noticationAction:");
        NotificationCenter.add(observer: observer, selector: selector, name: name);
    }
}

