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
    
    var actionTarget: Any!
    
    var selector: Selector!
    
    var entity: MessageModel!
    
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
    
    
    fileprivate var commentView: CommentItemView!
    var comments: [CommentModel]! {
        didSet{
            configComment();
        }
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
    
    private func configComment() {
        if comments != nil && commentView == nil {
            commentView = CommentItemView(frame: .init(x: leftPointX, y: nameLabel.maxY, width: maxWidth, height: 40));
            addSubview(commentView);
        }
        commentView?.comments = comments;
        commentView?.isHidden = comments == nil;
        
    }
    
    private func configContent(context: String?) -> Void {
        if context == nil {
            contextLabel?.text = "";
            return;
        }
        if contextLabel == nil {
            contextLabel = createLabel(rect: .init(x: leftPointX, y: topPointY, width: maxWidth, height: 20), text: "");
            contextLabel.numberOfLines = 0;
            contextLabel.font = MomentConfigPara.textFont;
            contextLabel.textColor = MomentConfigPara.textColor;
        }
        contextLabel.text = context;
    }
    
    
    func configMessage(model: MessageModel) -> Void {
        entity = model;
        nameLabel.text = model.name;
        configContent(context: model.contentText);
        comments = model.comment;
        
    }
    
    func addTarget(t: Any,sel: Selector) -> Void {
        self.actionTarget = t;
        selector = sel;
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        if entity == nil {
            return;
        }
        
        var rect = nameLabel.frame;
        rect.size = entity.nameSize;
        nameLabel.frame = rect;
        
        if let label = contextLabel {
            rect = label.frame;
            rect.size = entity.contextSize;
            label.frame = rect;
        }
        
        
        if  self is TextCell {
            
            var rect = tabBarView.frame;
            rect.origin.y = entity.topHeight;
            tabBarView.frame = rect;
            
        }else if let cell = self as? ImageCell {
            
            if let imageModel = entity as? ImageModel {
                
                
                rect = cell.backImage.frame;
                rect.origin.y = imageModel.supHeight;
                cell.backImage.frame = rect;
                
                rect = tabBarView.frame;
                rect.origin.y = cell.backImage.maxY;
                tabBarView.frame = rect;
            }
        }else if let cell = self as? MultiImageCell {
            
            
            
            guard let imgs = cell.multipleImages else {
                return;
            }
            let perWidth = (MomentConfigPara.maxWidth - 8 - 40) / 3;
            
            for item in imgs.enumerated() {
                let row = item.offset / 3;
                let column = item.offset % 3;
                let drawRect = CGRect(x: column.cgFloat * (perWidth + 4) + leftPointX, y: row.cgFloat * (perWidth + 4) + cell.topHeight, width: perWidth, height: perWidth);
                let img = cell.getImageBy(index: item.offset, rect: drawRect);
                img.image = item.element;
                img.isHidden = false;
                
            }
            if imgs.count < 9 {
                for idx in imgs.count...8 {
                    let img = cell.getImageBy(index: idx, rect: CGRect.zero);
                    img.isHidden = true;
                }
            }
            
            
            if let model = entity as? MultiImageModel {
                var rect = tabBarView.frame;
                rect.origin.y = model.topHeight;
                tabBarView.frame = rect;
            }
            
        }
        

        if let cView = commentView {
            rect = cView.frame;
            rect.origin.y = tabBarView.maxY;
            rect.size.height = entity.commentHeight;
            cView.frame = rect;
            
        }
        
    }
    
}
//only text
class TextCell: GroupCell {
    
    
}

class ImageCell: GroupCell {
    
    var backImage: UIImageView!
    
    override func configMessage(model: MessageModel) {
        super.configMessage(model: model);
        if let cModel = model as? ImageModel {
            backImage.image = cModel.image;
        }
    }
    
    
    override func configSubView() {
        backImage = createImageView(rect: .init(x: leftPointX, y: topPointY, width: 160, height: 200));
        addSubview(backImage);
        backImage.contentMode = .scaleAspectFill;
        backImage.clipsToBounds = true;
        
    }
}


class MultiImageCell: GroupCell {
    
    var multipleImages: [UIImage]! {
        didSet{
            setNeedsLayout();
        }
    }
    var topHeight: CGFloat {
        if let model = entity as? MultiImageModel {
            return model.supTopHeight;
        }
        return 0;
    }
    
    
    private var imageTag = 12345;

    override func configSubView() {
        backgroundColor = UIColor.white;
    }
    
    
    override func configMessage(model: MessageModel) {
        super.configMessage(model: model);
        if let imgsModel = model as? MultiImageModel {
            multipleImages = imgsModel.images;
        }
    }
    
    func getImageBy(index: Int,rect: CGRect) -> UIImageView {
        
        
        var img = viewWithTag(index + imageTag) as? UIImageView;
        if img == nil {
            
            img = createImageView();
            img?.tag = index + imageTag;
            img?.contentMode = .scaleAspectFill;
            img?.clipsToBounds = true;
        }
        if !rect.isNull {
            img?.frame = rect;
        }
        return img!;
    }
    
    override func addTarget(t: Any, sel: Selector) {
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fetchImageIndex(touches, isEnd: false);
        
    }
    func fetchImageIndex(_ touches: Set<UITouch>,isEnd: Bool) -> Void {
        guard let point = touches.first?.location(in: self) else{
            return;
        }
        var index = -1;
        for idx in 0...8 {
            let rect = getImageBy(index: idx, rect: CGRect.null).frame;
            if !rect.isNull && rect.contains(point) {
                index = idx;
                break;
            }
        }
        if index != -1 ,let sel = selector , isEnd{
            let obs = actionTarget as? NSObject;
            obs?.perform(sel, with: [JHSCellKey.cell:self,JHSCellKey.imgIndex:index]);
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fetchImageIndex(touches, isEnd: true);
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        fetchImageIndex(touches, isEnd: false);
    }

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
//comment view
class CommentItemView: BaseView {
    
    
    fileprivate var comments: [CommentModel]!{
        didSet{
            
            setNeedsDisplay();
        }
    }
}
