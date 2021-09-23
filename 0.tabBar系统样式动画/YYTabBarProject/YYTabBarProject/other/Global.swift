//
//  Global.swift
//  YYTabBarProject
//
//  Created by 杨世川 on 2021/9/23.
//

import UIKit
//MARK:- 判断是不是刘海 -
var isPhoneX: Bool {
    //1、iPhoneX最低版本11.0
    guard #available(iOS 11.0, *) else {
     return false
    }
    //2、判断safeArea.bottom是否为0
    let isX = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom != 0)
    return isX
}
