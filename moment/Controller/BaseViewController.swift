//
//  BaseViewController.swift
//  moment
//
//  Created by Allen Wu on 05/04/2024.
//

import UIKit
//import

class BaseViewController: BaseController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
}


extension UIViewController {
    func width() -> CGFloat {
        return view.frame.width;
    }
    func height() -> CGFloat {
        return view.frame.height;
    }
    
    func frame() -> CGRect {
        return self.view.frame;
    }
    func bounds(y: CGFloat = 0) -> CGRect {
        
        return CGRect(x: 0, y: y, width: width(), height: height() - y);
    }
    func addView(tempView: UIView) {
        self.view.addSubview(tempView);
    }
}
