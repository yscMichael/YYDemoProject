//
//  UIColor+Extension.swift
//  SkyPiCameraiOSProject
//
//  Created by 杨世川 on 2019/12/20.
//  Copyright © 2020 skyworth. All rights reserved.
//

import UIKit

extension UIColor{
    class func colorWithRGBHex(hex: UInt,_ alpha:CGFloat = 1) -> UIColor {
        let r: CGFloat = CGFloat((hex >> 16) & 0xFF)
        let g: CGFloat = CGFloat((hex >> 8) & 0xFF)
        let b: CGFloat = CGFloat(hex & 0xFF)
        
        return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}
