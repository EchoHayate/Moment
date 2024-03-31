//
//  RelationManager.swift
//  moment
//
//  Created by Allen Wu on 31/03/2024.
//

import Foundation

enum RelationFileKey: String {
//    case personList
    case locationList
    case allPersonList
    case limitedPersonDate
    
    case locationSelectedPersonList ///  选择一个科室 的人员
    
    case lockDatesOfPerson // 保存个人的锁定日期 等于task 状态
    
    case contentOffset
    case segmentIndex
    
  
    
    
}







class RelationManager: NSObject{
    
    
    class  func setKey(key: RelationFileKey,value: Any?) {
         instance.paramter[key.rawValue] = value;
     }
     class func value(key: RelationFileKey) -> Any? {
         return instance.paramter[key.rawValue];
     }
     class func setKey(key: String,value: Any?) {
         instance.paramter[key] = value;
     }
     class func value(key: String) -> Any? {
         return instance.paramter[key];
     }
    
}
