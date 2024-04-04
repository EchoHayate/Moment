//
//  ExtensionView.swift
//  moment
//
//  Created by Allen Wu on 03/04/2024.
//

import Foundation
import UIKit

extension UIView {
    
    //UITableViewCell is a subclass of UIView
    var minX: CGFloat{
        return frame.minX;
    }
    var maxY: CGFloat{
        return frame.maxY;
    }
    var minY: CGFloat {
        return frame.minY;
    }
    var midX: CGFloat {
        return frame.midX;
    }
    var midY: CGFloat {
        return frame.midY;
    }
    var maxX: CGFloat{
        return frame.maxX;
    }
    
    var height: CGFloat {
        return self.frame.height;
    }
    var width: CGFloat {
        return self.frame.width;
    }
    var size: CGSize {
        return bounds.size;
    }
}
    
    
    
extension UIView {
    
    func createImageView(rect: CGRect = CGRect.zero) -> UIImageView {
        let imageView = UIImageView(frame: rect);
        addSubview(imageView);
        imageView.backgroundColor = UIColor.white;
        imageView.clipsToBounds = true;
        imageView.contentMode = .scaleAspectFill;
        return imageView;
    }
    
    func createLabel(rect: CGRect = CGRect.zero,text: String = "") -> UILabel {
        let label = UILabel(frame: rect);
        label.backgroundColor = .white;
        label.font = UIFont.fitSize(size: 14);//fontSize(size: 14);
        label.textColor = .darkGray;
        addSubview(label);
        label.text = text;
        label.clipsToBounds = true;
        return label;
    }
    
}
