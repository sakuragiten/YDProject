//
//  UIKit+Extension.swift
//  StevenNash
//
//  Created by gongsheng on 2018/10/18.
//  Copyright © 2018 gongsheng. All rights reserved.
//

import UIKit


enum PIXELS {
    case ALPHA, BLUE, GREEN, RED
}

extension UIImage {
    
    //图片置灰
    func convertToGrayscale() -> UIImage {
        let size = self.size
        let width = Int(size.width)
        let height = Int(size.height)
        
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue)
        context?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let cgImage = context!.makeImage()
        let grayImage = UIImage(cgImage: cgImage!)
        return grayImage
    }
    
}



extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1);
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a);
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    class func color(hexString: String) -> UIColor {
        let r, g, b, a: CGFloat
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255.0
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255.0
                    b = CGFloat(hexNumber & 0x0000ff) / 255.0
                    a = 1
                    return self.init(red: r, green: g, blue: b, alpha: a)
                }
            }
        }
        return .clear
    }
    
    
}
