//
//  ScrollView.swift
//  moment
//
//  Created by Allen Wu on 05/04/2024.
//

import UIKit

class ScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        backgroundColor = UIColor.clear;
        showsVerticalScrollIndicator = false;
        showsHorizontalScrollIndicator = false;
        keyboardDismissMode = .onDrag;
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
