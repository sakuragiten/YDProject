//
//  UIKit+Extension.swift
//  YDProject
//
//  Created by gongsheng on 2018/11/1.
//

import UIKit

@objc public extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1);
    }
    
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}


@objc extension UIButton {
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        //获取当前button的实际大小
        var bounds = self.bounds
        
        //如果响应范围小于 44* 44 则放大响应区域 否则不变
        let widthDelta = CGFloat.maximum(44 - bounds.width, 0)
        let heightDelta = CGFloat.maximum(44 - bounds.height, 0)
        bounds = bounds.insetBy(dx: -widthDelta, dy: -heightDelta)
        return bounds.contains(point)
    }
}

@objc public extension NSAttributedString {
    
    var rangeOfAll: NSRange {
        get {
            return NSRange.init(location: 0, length: self.length);
        }
    }
    
}
