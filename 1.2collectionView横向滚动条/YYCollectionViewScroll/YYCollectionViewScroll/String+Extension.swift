//
//  String+Extension.swift
//  XPTCameraProject
//
//  Created by 杨世川 on 2021/10/13.
//

import UIKit

extension String{
    //MARK:获取字符串Size(方法一)
    func getStringSizeFromBoundingRect(font: UIFont) -> CGSize {
        let tempString = self as NSString
        let contentSize: CGSize = tempString.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:font], context: nil).size
        //向上取整,防止太小
        let width = ceil(contentSize.width)
        let height = ceil(contentSize.height)
        return CGSize(width: width, height: height)
    }
    
    //MARK:获取字符串Size(方法二)
    func getStringSizeFromSizeToFit(font: UIFont) -> CGSize {
        let label = UILabel.init(frame: CGRect.zero)
        label.text = self
        label.font = font
        label.sizeToFit()
        //向上取整,防止太小
        let width = ceil(label.frame.size.width)
        let height = ceil(label.frame.size.height)
        return CGSize(width: width, height: height)
    }
}
