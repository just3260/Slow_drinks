//
//  UIColor+SLOW.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/20.
//

import UIKit


// https://color.adobe.com/zh/search?q=cocktail

extension UIColor {
//    @nonobjc class var slowBackground: UIColor {
//        return UIColor(rgb: 0x182026)
//    }
//    @nonobjc class var slowButton: UIColor {
//        return UIColor(rgb: 0xA0A603)
//    }
//    @nonobjc class var slowSubButton: UIColor {
//        return UIColor(rgb: 0xBFBA73)
//    }
//    @nonobjc class var slowTitle: UIColor {
//        return UIColor(rgb: 0xF2CA50)
//    }
//    @nonobjc class var slowSubTitle: UIColor {
//        return UIColor(rgb: 0x364C59)
//    }
    
    
    @nonobjc class var slowBackground: UIColor {
        return UIColor(rgb: 0x393C40)
    }
    @nonobjc class var slowButton: UIColor {
        return UIColor(rgb: 0xBF9673)
    }
    @nonobjc class var slowSubButton: UIColor {
        return UIColor(rgb: 0xF2CA99)
    }
    @nonobjc class var slowTitle: UIColor {
        return UIColor(rgb: 0xF2E7AE)
    }
    @nonobjc class var slowSubTitle: UIColor {
        return UIColor(rgb: 0xF2F2F2)
    }
    
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

