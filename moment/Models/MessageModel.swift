//
//  File.swift
//  moment
//
//  Created by Allen Wu on 25/03/2024.
//

import Foundation
import SDWebImage
import SDWebImageSwiftUI
import UIKit

//list all the possibilities

enum MessageModelType: String{
    case text = "TextCell"//only text
    case image = "ImageCell"//only one iamge
    case webImage = "WebImageCell"
    case MutiImage = "MultiImageCell"//for mutiple images
    case new = "NewCell"
    case video = "VideoCell"
    case ad //advertisement
}



class MessageModel:NSObject{
    
    var name = "halo"
    var modelType: MessageModelType!
    var contentText:String!
    
    
    init(type: MessageModelType){
        super.init()
        modelType = type
        self.configData()
    }
    
    func configData() -> Void{
        
    }
    
    private var _contextSize:CGSize!
    

    var contextSize:CGSize{
        
        if contentText == nil{
            return CGSize.zero
        }
        if _contextSize != nil{
            return _contextSize
        }
        
        _contextSize = contentText.textSize(size: CGSize(
            width:MomentConfigPara.maxWidth,height:CGFloat.greatestFiniteMagnitude),font: MomentConfigPara.textFont)
//        guard let contentText = contentText else {
//                return CGSize.zero
//            }
//            
//            if _contextSize == nil {
//                _contextSize = contentText.textSize(size: CGSize(
//                    width: MomentConfigPara.maxWidth, height: CGFloat.greatestFiniteMagnitude), font: MomentConfigPara.textFont)
//            }
        
        return _contextSize
        }
    
    
//////////
    var nameSize: CGSize {
            let size = name.textSize(size: CGSize(width: MomentConfigPara.maxWidth, height: CGFloat.greatestFiniteMagnitude), font: MomentConfigPara.textFont);
            return size;
        }
            
    var topHeight: CGFloat {
        let ht = (contextSize.height + 8) + nameSize.height + 12;
        return ht;
//        let ht = contextSize.height + nameSize.height + 14;
//        return ht < 60 ? 60 : ht;
    }
    private var _cHeight: CGFloat = 0;
    var commentHeight: CGFloat {
        if comment == nil || comment.count == 0 {
            return 0;
        }
        if _cHeight != 0 {
            return _cHeight;
        }
        
        for (_,item) in comment.enumerated() {
            _cHeight += (item.size.height + 4)
        }
        _cHeight += 20;
        return _cHeight;
    }
    
    var rowHeight: CGFloat {
        return topHeight + commentHeight + 6;
    }
    
    
    var comment: [CommentModel]!
 

    
}

class CommentModel: NSObject {
    var person: CommentItemModel! // one who comments
    var endPeseron: CommentItemModel! // // person who is commented
    
    var content = "";
    
    private let reply = "回复";
    
    private let highlitedDict = [NSAttributedString.Key.foregroundColor:UIColor.red];
    
    private var replayRange: NSRange {
        return NSRange(location: pmRange.upperBound, length: reply.count);
    }
    
    private var replySize: CGSize {
        return getContentText().attributedSubstring(from: replayRange).boundSize();
    }
    
    var endNameSize: CGSize {
        if endPeseron == nil {
            return CGSize.zero;
        }
        let size = getContentText().attributedSubstring(from: endRange!).boundSize();
        return size;
    }
    
    private var _size: CGSize!;
    var size: CGSize {
        if _size != nil {
            return _size;
        }
        let size = getContentText().boundSize();
        _size = size;
        return _size;
    }
    
    var orgin: CGPoint!
    
    var nameSize: CGSize {
        return getContentText().attributedSubstring(from: pmRange).boundSize();
    }
    
    func containsPoint(point: CGPoint) -> (CommentItemModel,CGRect,CommentItemSelectedType)? {
        if orgin == nil {
            return nil;
        }
        let cRect = CGRect(origin: orgin, size: size);
        guard cRect.contains(point) else {
            return nil
        }
        let nRect = CGRect(origin: orgin, size: nameSize);
        if  nRect.contains(point) {
//            return (person,pmRange);
            return (person,nRect,CommentItemSelectedType.name);

        }
        let endRect = CGRect(origin: CGPoint(x: nRect.maxX + replySize.width, y: nRect.minY), size: endNameSize);
        if endRect.contains(point) {
            return (endPeseron,endRect,CommentItemSelectedType.name);
        }
        return endPeseron == nil ? (person,cRect,CommentItemSelectedType.text) : (endPeseron,cRect,CommentItemSelectedType.text);
    }
    
    
    var endRange: NSRange? {
        if endPeseron != nil {
            return NSRange(location: pmRange.upperBound + reply.count, length: endPeseron.name.count);
        }
        return nil;
    }
    
    //get the range of person
    var pmRange: NSRange {
        return NSRange(location: 0, length: person.name.count);
    }
    
    
    private var contentAttribute: NSAttributedString!
    func getContentText() -> NSAttributedString {
        if contentAttribute != nil {
            return contentAttribute;
        }

        if endRange == nil {
            let attribute = NSMutableAttributedString(string: person.name + "：" + content);
            attribute.addAttributes(highlitedDict, range: pmRange);
            contentAttribute = attribute;
            return attribute;
            
        }else {
            
            let attribute = NSMutableAttributedString(string: person.name + reply + endPeseron.name + "：" + content);
            attribute.addAttributes(highlitedDict, range: pmRange);
            attribute.addAttributes(highlitedDict, range: endRange!);
            contentAttribute = attribute;
            return attribute;
        }
        
     
        
        

        func containsPoint(point: CGPoint) -> (CommentItemModel,CGRect,CommentItemSelectedType)? {
            if orgin == nil {
                return nil;
            }
            let cRect = CGRect(origin: orgin, size: size);
            guard cRect.contains(point) else {
                return nil
            }
            let nRect = CGRect(origin: orgin, size: nameSize);
            if  nRect.contains(point) {
    //            return (person,pmRange);
                return (person,nRect,CommentItemSelectedType.name);

            }
            let endRect = CGRect(origin: CGPoint(x: nRect.maxX + replySize.width, y: nRect.minY), size: endNameSize);
            if endRect.contains(point) {
                return (endPeseron,endRect,CommentItemSelectedType.name);
            }
            return endPeseron == nil ? (person,cRect,CommentItemSelectedType.text) : (endPeseron,cRect,CommentItemSelectedType.text);
        }
        
    }

    
    
    
}

class TextModel: MessageModel {
    
}

class CommentItemModel: NSObject {
    var name = ""; //name
    var id = ""; // usrname id
    var profile = ""// avatar
    

}



extension NSAttributedString {
    func boundSize() -> CGSize {
        
        if let size = RelationManager.value(key: mainKey) as? CGSize {
            return size;
        }
        let size = boundingRect(with: CGSize(width: MomentConfigPara.maxWidth - 8, height: CGFloat.greatestFiniteMagnitude), options: [.usesFontLeading,.usesLineFragmentOrigin], context: nil).size;
        RelationManager.setKey(key: mainKey, value: size);
        return size;
    }
    var mainKey: String {
        return string.MD5String;
    }
}

enum CommentItemSelectedType {
    case known
    case name
    case text
}

class ImageModel: MessageModel {
    var urlString = "https:picsum.photos/id/237/200/300";
    var image = UIImage(named: "1.jpeg");
    
    override var topHeight: CGFloat {
        let ht = super.topHeight;
        return ht + 200;
    }
    var supHeight: CGFloat {
        return super.topHeight;
    }
    
    
    
//    func loadImage() {
//            guard let url = URL(string: urlString) else { return }
//            
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data, error == nil else { return }
//                
//                DispatchQueue.main.async {
//                    self.image = UIImage(data: data)
//                    // 这里可以更新 UI 或者做其他操作
//                }
//            }
//            
//            task.resume()
//        }
    
}




class WebImageModel: MessageModel {
    var image: UIImage?

    override var topHeight: CGFloat {
        let ht = super.topHeight
        return ht + 200
    }

    var supHeight: CGFloat {
        return super.topHeight
    }
    func downloadAndSaveImage(from urlString: String) -> MessageModel {
        guard let url = URL(string: urlString) else { return self }
        
        // 使用SDWebImage下载图片并设置到imageView上
        let imageView = UIImageView()
        imageView.sd_setImage(with: url, completed: { [weak self] (downloadedImage, error, cacheType, url) in
            DispatchQueue.main.async {
                if let image = downloadedImage {
                    // 图片下载成功，保存到image属性中
                    self?.image = image
                    // 如果需要，将图片缓存到沙盒
                    SDImageCache.shared.store(image, forKey: url?.absoluteString)
                    print("图片下载并保存成功")
                } else if let error = error {
                    print("图片下载失败: \(error.localizedDescription)")
                }
            }
        })
        
        return self
    }

//    func downloadAndSaveImage(from urlString: String) -> MessageModel {
//        guard let url = URL(string: urlString) else { return self}
//        // 使用SDWebImage下载图片
        
//        let imageView = UIImageView()
//        imageView.sd_setImage(with: url, completed: { [weak self] (downloadedImage, error, cacheType, url) in
//            if let image = downloadedImage {
//                // 图片下载成功，保存到image属性中
//                DispatchQueue.main.async {
//                    self?.image = image
//                }
//                SDWebImageManager.shared.loadImage(with: url as URL?, options: SDWebImageOptions.highPriority, progress: { (receivedSize:Int,expectedSize:Int,targetURL:URL?) in
//                    
//                }, completed:{ (image, data, error, SDImageCacheType, result, url) in
//                    imageView.image = image;
//                    // 下载图片后不会将图片缓存到沙盒，需要手动调用SDImageCache.shared.store保存到沙盒
//                    SDImageCache.shared.store(image, forKey: url?.absoluteString, completion: {
//                        print("图片保存成功");
//                    })})
//        
//                // 这里可以添加额外的代码来处理下载的图片，例如保存到相册等
//            } else if let error = error {
//                print("图片下载失败: \(error.localizedDescription)")
//            }
//        })
//        return self
//    }
}

//    imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.jpg"), placeholderImage: UIImage(named: "placeholder.png"))

//https:picsum.photos/id/237/200/300

class MultiImageModel: MessageModel {
    
//    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
//        let myIdentifier = "MyIdentifier"
//        let cell = tableView.dequeueReusableCellWithIdentifier(myIdentifier, forIndexPath: indexPath) as UITableViewCell
//        
//        cell.imageView.sd_setImageWithURL(imageUrl, placeholderImage:placeholderImage)
//        return cell
//    }
//    
//    
//    var body: some View{
//        
//    }
    
    var images: [UIImage]!
    var count = 8 {
        didSet{
            count = count > 8 ? 8: count;
            images.removeAll();
            for idx in 0...count {
                images.append(UIImage(named: "\(idx).jpg")!);
            }
        }
    }

    
    override func configData() {
        images = [UIImage]();
        for idx in 0...count {
            if let image = UIImage(named: "\(idx).jpg") {
                images.append(image)
            } else {
                print("Failed to load image \(idx).jpg")
            }

            //images.append(UIImage(named: "\(idx).jpg")!);
        }
    }
    
    //for square images, height=width
    override var topHeight: CGFloat {
        if images == nil {
            return super.topHeight;
        }
        let perWidth = (MomentConfigPara.maxWidth - 8 - 40) / 3 + 4;
        let row = ceil(Double(images.count) / 3.0)
        return super.topHeight + perWidth * CGFloat(row);
    }
    
    var supTopHeight: CGFloat {
        return super.topHeight;
    }
    
    var cellImageHeight: CGFloat {
        return topHeight - super.topHeight;
    }
}






