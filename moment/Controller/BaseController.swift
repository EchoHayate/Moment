//
//  BaseController.swift
//  moment
//
//  Created by Allen Wu on 04/04/2024.
//

import Foundation
import UIKit
import CoreGraphics

class BaseController: UIViewController {
    
}




extension BaseController {
    
    func addRefresh(scrollView: UIScrollView) -> Void {
        let refreshView = UIRefreshControl();
        refreshView.addTarget(self, action: #selector(beginRefreshData(_:)), for: .valueChanged);
        scrollView.refreshControl = refreshView;
    }

    
    @objc func beginRefreshData(_ refreshView: UIRefreshControl) -> Void {
        
    }
    
    
    func addSubview(subView: UIView) -> Void {
        view.addSubview(subView);
    }
}
