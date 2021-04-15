//
//  UIView+SLOW.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/15.
//

import UIKit

extension UIView {
    func bordered(_ color: UIColor, radius: CGFloat = 4) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = radius
    }
    
    func topRoundCorner(radius: CGFloat = 4) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [ .topLeft, .topRight ], cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    func roundCorner(radius: CGFloat = 4) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func shadow(color: UIColor, offset: CGSize, blur: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = blur / 2.0
    }
    
    func firstResponder() -> UIView? {
        if self.isFirstResponder {
            return self
        }
        
        for subview in self.subviews {
            if let firstResponder = subview.firstResponder() {
                return firstResponder
            }
        }
        
        return nil
    }
    
    func shake(count : Float = 4, for duration : TimeInterval = 0.4, withTranslation translation : Float = 5) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
