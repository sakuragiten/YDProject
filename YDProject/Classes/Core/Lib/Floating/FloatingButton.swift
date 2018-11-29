//
//  FloatingButton.swift
//  YDProject
//
//  Created by gongsheng on 2018/11/29.
//

import UIKit
import AudioToolbox

private let floatBtnWidth: CGFloat = 60.0
private let edgeW: CGFloat = 15.0
private let screenW = UIScreen.main.bounds.width
private let screenH = UIScreen.main.bounds.height
private let radius: CGFloat = 160.0

@objc public class FloatingButton: UIView {
    
    
    private var lastPosition: CGPoint?
    private var lastPositionInself: CGPoint?

    static let floatBtn = FloatingButton()
    let circleView = SemiCircleView(frame: CGRect(x: screenW, y: screenH, width: radius, height: radius))
    
    
    public override init(frame: CGRect) {
        
        let frame = CGRect(x: screenW - floatBtnWidth - edgeW, y: 200, width: floatBtnWidth, height: floatBtnWidth)
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.randomColor()
        self.layer.cornerRadius = floatBtnWidth * 0.5
        self.layer.masksToBounds = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



extension FloatingButton {
    
    @objc public class func show(){
        
        guard floatBtn.circleView.superview == nil else {return};
        
        
        UIApplication.shared.keyWindow?.addSubview(floatBtn.circleView)
        UIApplication.shared.keyWindow?.bringSubviewToFront(floatBtn.circleView)
        
        floatBtn.frame = CGRect(x: screenW - floatBtnWidth - edgeW, y: 200, width: floatBtnWidth, height: floatBtnWidth)
        UIApplication.shared.keyWindow?.addSubview(floatBtn)
        UIApplication.shared.keyWindow?.bringSubviewToFront(floatBtn)
    }
    
    @objc public class func show(imageName: String) {
        
        print(floatBtn.circleView.superview as Any)
        show()
        guard let image = UIImage(named: imageName) else {return}
        floatBtn.layer.contents = image.cgImage
        
        
    }
    
}


// Mark - moving & click Action
extension FloatingButton {
    
    //开始拖动
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lastPosition = touches.randomElement()?.location(in: self.superview)
        lastPositionInself = touches.randomElement()?.location(in: self)
    }
    
    //拖动中
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentPosition = touches.randomElement()?.location(in: self.superview)
    
        

        var x = currentPosition!.x + (floatBtnWidth * 0.5 - lastPositionInself!.x)
        var y = currentPosition!.y + (floatBtnWidth * 0.5 - lastPositionInself!.y)
        
        //floatBtnWidth * 0.5 <= x <= screenW - floatBtnWidth * 0.5
        x = max(floatBtnWidth * 0.5, min(x, screenW - floatBtnWidth * 0.5))
        //floatBtnWidth * 0.5 <= y <= screenH - floatBtnWidth * 0.5

        var top: CGFloat = 0;
        var bottom: CGFloat = 0;
        if #available(iOS 11, *) {
            top = top + UIApplication.shared.keyWindow!.safeAreaInsets.top;
            bottom = bottom + UIApplication.shared.keyWindow!.safeAreaInsets.bottom;
        }
        y = max(floatBtnWidth * 0.5 + top, min(y, screenH - floatBtnWidth * 0.5 - bottom))
        
        self.center = CGPoint(x: x, y: y);
        
        if circleView.frame.origin.x == screenW {
            //未显示出来
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame = CGRect(x: screenW - radius, y: screenH - radius, width: radius, height: radius)
            }
        }
        
        let distance = CGFloat(sqrt(pow(screenW - x, 2) + pow(screenH - y, 2)))
        if distance + floatBtnWidth * 0.5 <= radius {
            //范围内
            let r = radius + 10
            if self.circleView.frame.width == radius {
                //给点震动感
                AudioServicesPlaySystemSound(1519)
            }
            self.circleView.frame = CGRect(x: screenW - r, y: screenH - r, width: r, height: r)
        } else if self.circleView.frame.width == radius + 10 {
            self.circleView.frame = CGRect(x: screenW - radius, y: screenH - radius, width: radius, height: radius)
        }
        
        
    }
    
    
    
    
    //结束拖动
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let currentPosition = touches.randomElement()?.location(in: self.superview)
        if currentPosition == lastPosition {
            //点击事件
            print("Click Action")
        } else {
            //拖动结束
            print("Moving end")
            
            var x = self.center.x
            let y = self.center.y
            let distance = CGFloat(sqrt(pow(screenW - x, 2) + pow(screenH - y, 2)))
            if distance + floatBtnWidth * 0.5 <= radius {
                //范围内
                UIView.animate(withDuration: 0.3, animations: {
                    self.circleView.frame = CGRect(x: screenW, y: screenH, width: floatBtnWidth, height: floatBtnWidth)
                    self.frame = CGRect(x: screenW, y: screenH, width: radius, height: radius)
                }, completion:{ _ in
                    self.removeFromSuperview()
                    self.circleView.removeFromSuperview()
                })
            } else {
                x = x < screenW * 0.5 ? floatBtnWidth * 0.5 + edgeW : screenW - floatBtnWidth * 0.5 - edgeW
                UIView.animate(withDuration: 0.3) {
                    self.center = CGPoint(x: x, y: y);
                    self.circleView.frame = CGRect(x: screenW, y: screenH, width: floatBtnWidth, height: floatBtnWidth)
                }
            }
           

            
            
            
        }
        
        
        
        
    }
    
    
    
    
}



@objc public class SemiCircleView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SemiCircleView {
    
    public override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath.init(arcCenter: CGPoint(x: self.frame.width, y: self.frame.height), radius: self.frame.height, startAngle: CGFloat(Double.pi * 0.5), endAngle: CGFloat(Double.pi), clockwise: false)
        UIColor.red.setFill()
        path.fill()
    }
    
}
