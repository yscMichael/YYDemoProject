//
//  YYTestViewModel.swift
//  YYGCDTestProject
//
//  Created by 杨世川 on 2021/11/26.
//

import UIKit

class YYTestViewModel: NSObject {
    func querySubDeviceList(success: @escaping(_ success:String) -> (),
                            failure: @escaping(_ error: String) -> ()){
        self.beginOtherThread(success: success, failure: failure)
    }
    
    //MARK:开启另一个延时线程
    func beginOtherThread(success: @escaping(_ success:String) -> (),
                          failure: @escaping(_ error: String) -> ()) -> () {
        DispatchQueue.global().async {
            let randomTime = arc4random() % 5
            Thread.sleep(forTimeInterval: TimeInterval(randomTime))
            let randomString = 100 + arc4random() % 100
            success(String(randomString))
        }
    }
}

