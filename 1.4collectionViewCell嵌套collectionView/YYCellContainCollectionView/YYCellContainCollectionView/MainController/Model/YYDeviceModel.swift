//
//  YYDeviceModel.swift
//  YYCellContainCollectionView
//
//  Created by 杨世川 on 2021/10/18.
//

import UIKit

class YYDeviceModel: NSObject {
    //设备名称
    var deviceName: String = ""
    //自己的iotId
    var iotId: String = ""
    //父iotId
    var parentIotId: String = ""
    //是否显示子设备
    var isShowSubDevice: Bool = false
    //是否展开子设备
    var isOpenSubDevice: Bool = false
    
    //子设备数量
    var subDeviceCount: Int = 0
    //cell的高度
    var subCollectionViewHeight: Int = 0
}
