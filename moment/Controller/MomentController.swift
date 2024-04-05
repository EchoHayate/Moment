//
//  MomentController.swift
//  moment
//
//  Created by Allen Wu on 05/04/2024.
//

import UIKit

class MomentController: BaseViewController {
    
    let list = createData();
    
    var cellsIdentifier = [MessageModelType]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        createTable(delegate: self);
        cellsIdentifier.append(.text);
        cellsIdentifier.append(.image);
        cellsIdentifier.append(.MutiImage);
        cellsIdentifier.append(.new);
        cellsIdentifier.append(.ad);
        cellsIdentifier.append(.video);
        
        baseTable.separatorStyle = .singleLine;
        
        registerCellToTable();
    }
    
    
    func registerCellToTable() -> Void {
        for item in cellsIdentifier {
            if let cls = item.rawValue.clsType {
                baseTable.register(cls, forCellReuseIdentifier: item.rawValue);
            }
        }
    }
}
