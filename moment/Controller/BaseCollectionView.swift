//
//  BaseCollectionView.swift
//  moment
//
//  Created by Allen Wu on 05/04/2024.
//

import Foundation
import UIKit

class BaseCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        showsVerticalScrollIndicator = false;
        showsHorizontalScrollIndicator = false;
        backgroundColor = UIColor.clear;
        keyboardDismissMode = .onDrag
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
