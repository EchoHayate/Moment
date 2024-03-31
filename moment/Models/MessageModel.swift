//
//  File.swift
//  moment
//
//  Created by Allen Wu on 25/03/2024.
//

import Foundation

//list all the possibilities

enum MessageModelType: String{
    case text = "TextCell"//only text
    case image = "ImageCell"//only one iamge
    case MutiImage = "MutiImageCell"//for mutiple images
    case new = "NewCell"
    case video = "VideoCell"
    case ad //advertisement
}



class MessageModel:NSObject{
    
    var name = "no"
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
        if contentText != nil{
            return _contextSize
        }
        
        _contextSize = contentText.textSize(size: CGSize(
            width:MomentConfigPara.maxWidth，height:CGFloat.greatestFiniteMagnitude),font:MomentconfigPara.textFont)
        
        return _contextSize
        }
    
    
    var nameSize:CGSize{
        let size = name.textSize()
    
        
        
        
    }
    
}


