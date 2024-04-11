//
//  BaseView.swift
//  moment
//
//  Created by Allen Wu on 04/04/2024.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        backgroundColor = UIColor.white;
        configSubView();
        
    }
    func configSubView() -> Void {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
