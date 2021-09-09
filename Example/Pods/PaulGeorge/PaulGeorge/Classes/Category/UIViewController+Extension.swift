//
//  UIViewController+Extension.swift
//  StevenNash
//
//  Created by gongsheng on 2018/10/8.
//  Copyright © 2018 gongsheng. All rights reserved.
//

import UIKit


extension UIViewController {
    
    public class func instanceFromeXib() -> Self {
        return instanceFromeXib(type: self)
    }
    
    private class func instanceFromeXib<T>(type: T.Type) -> T {
        let nibName = getClassName()
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.last as! T
    }

//    
    
}
