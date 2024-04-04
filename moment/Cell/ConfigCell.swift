//
//  ConfigCell.swift
//  moment
//
//  Created by Allen Wu on 03/04/2024.
//

import Foundation
import UIKit


enum JHSCellKey {
    case cell
    case index
    case imgIndex
    
}

class GroupCell: UITableViewCell {
    
    var tabBarView: OperationView!
    
    var leftImage: UIImageView!
    
    var nameLabel: UILabel!
    
    var contextLabel: UILabel!
    
    var leftPointX: CGFloat {
        return leftImage.maxX + 10;
    }
    var topPointY: CGFloat {
        return nameLabel.maxY + 8;
    }
    var maxWidth: CGFloat {
        return MomentConfigPara.maxWidth
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        backgroundColor = UIColor.white;
        selectionStyle = .none;
        leftImage = createImageView(rect: .init(x: 10, y: 10, width: 40, height: 40));
        leftImage.contentMode = .scaleAspectFill;
        leftImage.clipsToBounds = true;
        leftImage.layer.masksToBounds = true;
        leftImage.layer.cornerRadius = 4;
        leftImage.image = UIImage(named: "1.jpg");
        
        
        nameLabel = createLabel(rect: .init(x: leftPointX, y: 10, width: 20, height: 14), text: "姓名");
        nameLabel.font = MomentConfigPara.textFont;
        nameLabel.textColor = MomentConfigPara.textColor;
        
        tabBarView = OperationView(frame: .init(x: leftPointX, y: topPointY, width: MomentConfigPara.maxWidth, height: 30));
        addSubview(tabBarView);
        
        
        configSubView();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configSubView() -> Void {
        
    }
    
    
    
    
    class OperationView: BaseView {
        
        var leftTime: UILabel!
        var rightBar: UIButton!
        var rightLabel: UILabel!
        override func ConfigSubView() {
            
            
            leftTime = createLabel(rect: .init(x: 0, y: 0, width: width/2, height: height), text: "3分钟前");
            leftTime.textColor = MomentConfigPara.textColor;
            leftTime.font = MomentConfigPara.textFont;
            
            
            rightLabel = createLabel(rect: .init(x: leftTime.maxX, y: 0, width: width/2, height: height), text: "点赞");
            rightLabel.textAlignment = .right;
            rightLabel.textColor = MomentConfigPara.textColor;
            rightLabel.font = MomentConfigPara.textFont;
            
            
        }
    }

    
    
    
}

