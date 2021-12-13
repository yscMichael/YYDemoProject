//
//  ViewController.swift
//  YYGCDTestProject
//
//  Created by 杨世川 on 2021/11/26.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - 属性 -
    var testViewModel: YYTestViewModel = YYTestViewModel()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.layoutViews()
        self.initData()
    }
    
    //MARK:初始化Views
    func initViews() -> () {
        
    }
    
    //布局子View
    func layoutViews() -> () {
        
    }
    
    //初始化数据
    func initData() -> () {
        //test1()
        //test2()
        //test3()
        test4()
    }
    
    //MARK:test1
    func test1() -> () {
        let group = DispatchGroup()
        let queue = DispatchQueue.init(label: "test")
        for _ in 0..<5 {
            queue.async(group: group, execute: {
                self.testViewModel.querySubDeviceList { success in
                    print(success)
                } failure: { error in
                    
                }
            })
        }
        group.notify(queue: queue) {
            print("结束了")
        }
    }
    
    //MARK:test2
    func test2() -> () {
        let group = DispatchGroup()
        let queue = DispatchQueue.init(label: "test")
        for _ in 0..<5 {
            queue.async(group: group, execute: {
                let testViewModel = YYTestViewModel()
                testViewModel.querySubDeviceList { success in
                    print(success)
                } failure: { error in
                    
                }
            })
        }
        group.notify(queue: queue) {
            print("结束了")
        }
    }
    
    //MARK:test3
    func test3() -> () {
        let group = DispatchGroup()
        let queue = DispatchQueue.init(label: "test")
        for index in 0..<5 {
            group.enter()
            self.testViewModel.querySubDeviceList { success in
                print(success + "======\(index)")
                group.leave()
            } failure: { error in
                group.leave()
            }
        }
        group.notify(queue: queue) {
            print("结束了")
        }
    }
    
    //MARK:test4
    func test4() -> () {
        let group = DispatchGroup()
        let queue = DispatchQueue.init(label: "test")
        for index in 0..<5 {
            //group.enter()
            let testViewModel = YYTestViewModel()
            testViewModel.querySubDeviceList { success in
                print(success + "======\(index)")
                //group.leave()
            } failure: { error in
                //group.leave()
            }
        }
        group.notify(queue: queue) {
            print("结束了")
        }
    }
    
    //MARK: - Event Response -
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -

