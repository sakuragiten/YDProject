//
//  FloatingAnimationTransition.swift
//  AFNetworking
//
//  Created by gongsheng on 2018/11/29.
//

import UIKit

class FloatingAnimationTransition: NSObject {
    
    var currentFrame: CGRect = CGRect.zero

}


extension FloatingAnimationTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        containerView.addSubview(toView)
        
        
        let imageView = FloatingImageView(frame: toView.bounds)
        containerView.addSubview(imageView)
        //截屏
        UIGraphicsBeginImageContext(toView.frame.size)
        toView.layer.render(in: UIGraphicsGetCurrentContext()!)
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toView.isHidden = true
        
        imageView.startAnimating(toView: toView, fromRect: currentFrame, toRect: toView.bounds)
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            transitionContext.completeTransition(true)
        }
        
    }
}



private class FloatingImageView: UIImageView {
    
    var shapeLayer: CAShapeLayer!
    weak var toView: UIView?
    
    func startAnimating(toView: UIView, fromRect: CGRect, toRect: CGRect) {
        
        self.toView = toView
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath.init(roundedRect: fromRect, cornerRadius: fromRect.width * 0.5).cgPath
        self.layer.mask = shapeLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = UIBezierPath.init(roundedRect: toRect, cornerRadius: fromRect.width * 0.5).cgPath as Any
        animation.duration = 0.5
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        
        shapeLayer.add(animation, forKey: nil)
        
    }
}

extension FloatingImageView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        toView?.isHidden = false
        
        shapeLayer.removeAllAnimations()
        self.removeFromSuperview()
    }
}
