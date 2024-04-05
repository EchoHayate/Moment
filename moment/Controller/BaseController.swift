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
    var baseTable: BaseTableView!
    
    
    
    
    
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

extension BaseController {
    var navigateRect: CGRect {
        return CGRect(x: 0, y: 64, width: width(), height: height() - 64);
    }
    
    var tabbarRect: CGRect {
        return CGRect(x: 0, y: 64, width: width(), height: height() - 64 - 49);
    }
}


extension BaseController : UITableViewDelegate,UITableViewDataSource {
    
    func createTable(delegate: UITableViewDataSource & UITableViewDelegate) {
        createTable(frame: navigateRect, delegate: delegate);
    }
    
    
    func createTable(frame: CGRect,delegate: UITableViewDataSource&UITableViewDelegate) -> Void {
        
        baseTable = BaseTableView(frame: frame);
        baseTable.delegate = delegate;
        baseTable.dataSource = delegate;
        view.addSubview(baseTable);
        baseTable.estimatedSectionHeaderHeight = 0;
        baseTable.estimatedRowHeight = 0;
        
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
