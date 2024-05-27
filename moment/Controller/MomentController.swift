//
//  MomentController.swift
//  moment
//
//  Created by Allen Wu on 05/04/2024.
//

import UIKit

class MomentController: BaseViewController {
    
    
//    let tableView = UITableView()////
    
    let list = createData();
    
    var cellsIdentifier = [MessageModelType]();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 将 tableView 添加到 MomentController 的视图层次结构中
//        self.view.addSubview(tableView)
//
//       // 设置 tableView 的位置和大小
//        tableView.frame = self.view.bounds
        
        
        createTable(delegate: self);
        cellsIdentifier.append(.text);
        cellsIdentifier.append(.image);
        cellsIdentifier.append(.webImage)
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = list[indexPath.row];
        return model.rowHeight + 30;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = list[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: model.modelType.rawValue, for: indexPath) as! GroupCell;
        cell.configMessage(model: model);
        cell.actionTarget = self;
        cell.selector = #selector(cellActionItem(_:));
        return cell;
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc func cellActionItem(_ any: Any) -> Void {

        guard let dict = any as? [JHSCellKey:Any],
            let cell = dict[.cell] as? GroupCell,
        let indexPath = baseTable.indexPath(for: cell) else{
            return;
        }
        
        if let mImageCell = cell as? MultiImageCell {
            let index = (dict[.imgIndex] as? Int) ?? 0;
            let ctrl = PhotoViewController();
            ctrl.images = mImageCell.multipleImages;
            ctrl.index = index
            navigationController?.pushViewController(ctrl, animated: true);
            return;
        }
//        let item  = list[indexPath.row];
//        if let model = item as? JHSNewModel {
//            let ctrl = JHSHTMLViewController();
//            ctrl.urlString = model.link;
//            navigationController?.pushViewController(ctrl, animated: true);
//            return;
//        }
        
        
        
        
    }
}
