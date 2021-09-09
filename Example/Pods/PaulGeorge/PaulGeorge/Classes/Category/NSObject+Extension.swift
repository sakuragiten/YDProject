//
//  NSObject+Extension.swift
//  StevenNash
//
//  Created by gongsheng on 2018/10/8.
//  Copyright © 2018 gongsheng. All rights reserved.
//

import Foundation


extension NSObject {
    public class func getClassName() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public func getClassFromString(_ name: String) -> AnyClass {
        // swift4中通过字符串名转化成类，需要在字符串名前加上项目的名称
        let bundleName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        let className = bundleName! + "." + name
        return NSClassFromString(className)!
    }
}
