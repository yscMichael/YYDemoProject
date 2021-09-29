//
//  SPCMainTabViewController.swift
//  testApp
//
//  Created by 杨世川 on 2021/9/22.
//

import UIKit

//MARK:- 常量 -
//49 + 34
//64 + 34
let SPCTabBarHeightBig: CGFloat = 64 + 34
let SPCTabBarHeightSmall: CGFloat = 64
let SPCTabCount: Int = 5
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

class SPCMainTabViewController: UITabBarController {
    //MARK: - 属性 -
    var indexFlag: Int = 0
    //图片数组
    var imageArray: Array<Array<CGImage>> = Array<Array<CGImage>>()
    
    //MARK: - Life Cycle -
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //1、tabbar高度修改
        var frame = self.tabBar.frame
        frame.size.height = isPhoneX ? SPCTabBarHeightBig:SPCTabBarHeightSmall
        frame.origin.y = self.view.frame.size.height - frame.size.height
        self.tabBar.frame = frame
        self.tabBar.backgroundColor = UIColor.black
        self.tabBar.barStyle = UIBarStyle.black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTabBar()
        self.initChildController()
        self.initHomeIcon()
        self.initData()
    }
    
    func initTabBar() -> () {
        //设置是否透明
        tabBar.isTranslucent = false
        //设置展示样式(全屏展示)
        modalPresentationStyle = .fullScreen
        //设置背景颜色
        tabBar.barTintColor = UIColor.white
        //设置底部标签选中和未选中颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12)], for: .selected)
    }
    
    func initChildController() -> () {
        //1、初始化控制器
        //首页
        let homeCtrl = SPCHomeController.init()
        homeCtrl.tabBarItem.image = UIImage(named: "tabbar_icon_index_normal")?.withRenderingMode(.alwaysOriginal)
        homeCtrl.tabBarItem.selectedImage = UIImage(named: "tabbar_icon_index_normal")?.withRenderingMode(.alwaysOriginal)
        homeCtrl.tabBarItem.title = "首页"
        //消息
        let messageCtrl = SPCMessageController.init()
        messageCtrl.tabBarItem.image = UIImage(named: "tabbar_icon_news_normal")?.withRenderingMode(.alwaysOriginal)
        messageCtrl.tabBarItem.selectedImage = UIImage(named: "tabbar_icon_news_selected")?.withRenderingMode(.alwaysOriginal)
        messageCtrl.tabBarItem.title = "消息"
        //发现
        let findCtrl = SPCFindController.init()
        findCtrl.tabBarItem.image = UIImage(named: "tabbar_icon_mall_normal")?.withRenderingMode(.alwaysOriginal)
        findCtrl.tabBarItem.selectedImage = UIImage(named: "tabbar_icon_mall_selected")?.withRenderingMode(.alwaysOriginal)
        findCtrl.tabBarItem.title = "发现"
        //云服务
        let cloudCtrl = SPCCloudController.init()
        cloudCtrl.tabBarItem.image = UIImage(named: "tabbar_icon_icloud_normal")?.withRenderingMode(.alwaysOriginal)
        cloudCtrl.tabBarItem.selectedImage = UIImage(named: "tabbar_icon_icloud_selected")?.withRenderingMode(.alwaysOriginal)
        cloudCtrl.tabBarItem.title = "云服务"
        //我的
        let mineCtrl = SPCMineController.init()
        mineCtrl.tabBarItem.image = UIImage(named: "tabbar_icon_mine_normal")?.withRenderingMode(.alwaysOriginal)
        mineCtrl.tabBarItem.selectedImage = UIImage(named: "tabbar_icon_mine_selected")?.withRenderingMode(.alwaysOriginal)
        mineCtrl.tabBarItem.title = "我的"
        //设置子控制器
        self.viewControllers = [homeCtrl,messageCtrl,findCtrl,cloudCtrl,mineCtrl]
        //2、设置字体位置
        //设置首页标题向上偏移
        homeCtrl.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        messageCtrl.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        findCtrl.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        cloudCtrl.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        mineCtrl.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
    }
    
    func initHomeIcon() -> () {
        let centerX = Int(UIScreen.main.bounds.size.width)/SPCTabCount/2
        let height = isPhoneX ? SPCTabBarHeightBig:SPCTabBarHeightSmall
        let centerY = (height - 34)/2
        
        self.tabBar.addSubview(self.homeImageView)
        self.homeImageView.center = CGPoint(x: CGFloat(centerX), y: centerY)
        
        //self.tabBar.addSubview(self.lineView)
        //self.lineView.center = CGPoint(x: ScreenWidth/2, y: centerY)
    }
    
    //MARK:初始化Views
    func initViews() -> () {
        
    }
    
    //布局子View
    func layoutViews() -> () {
        
    }
    
    func initData() -> () {
        //首页
        var homeArray = Array<CGImage>()
        for index in 1...28 {
            let nameString = "index_navigation bar_icon_a" + "\(index)"
            let image = UIImage(named: nameString)?.withRenderingMode(.alwaysOriginal).cgImage
            homeArray.append(image!)
        }
        //消息
        var messageArray = Array<CGImage>()
        for index in 1...20 {
            let nameString = "index_navigation bar_icon_b" + "\(index)"
            let image = UIImage(named: nameString)?.withRenderingMode(.alwaysOriginal).cgImage
            messageArray.append(image!)
        }
        //发现
        var findArray = Array<CGImage>()
        for index in 1...20 {
            let nameString = "index_navigation bar_icon_c" + "\(index)"
            let image = UIImage(named: nameString)?.withRenderingMode(.alwaysOriginal).cgImage
            findArray.append(image!)
        }
        //云服务
        var cloudArray = Array<CGImage>()
        for index in 1...20 {
            let nameString = "index_navigation bar_icon_d" + "\(index)"
            let image = UIImage(named: nameString)?.withRenderingMode(.alwaysOriginal).cgImage
            cloudArray.append(image!)
        }
        //我的
        var mineArray = Array<CGImage>()
        for index in 1...20 {
            let nameString = "index_navigation bar_icon_e" + "\(index)"
            let image = UIImage(named: nameString)?.withRenderingMode(.alwaysOriginal).cgImage
            mineArray.append(image!)
        }
        self.imageArray.append(homeArray)
        self.imageArray.append(messageArray)
        self.imageArray.append(findArray)
        self.imageArray.append(cloudArray)
        self.imageArray.append(mineArray)
    }
    
    //MARK: - Event Response -
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    lazy var homeImageView: UIImageView = {
        let homeImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        homeImageView.image = UIImage(named: "tabbar_icon_index_selected")
        return homeImageView
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 1.0))
        lineView.backgroundColor = UIColor.black
        return lineView
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
extension SPCMainTabViewController: UITabBarControllerDelegate{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("UITabBarControllerDelegate")
        let index = self.tabBar.items?.firstIndex(of: item)
        print(index ?? 000)
        if index != self.indexFlag {
            var array = Array<Any>()
            //1、获取UITabBarButton数组
            for btn in self.tabBar.subviews {
                if btn.isKind(of: NSClassFromString("UITabBarButton")!) {
                    array.append(btn)
                }
            }
            //2、添加动画(判断是否是首页)
            let tabBarButton = array[index ?? 0] as! UIView
            if index == 0 {//首页
                self.homeImageView.isHidden = false
                //添加图层
                let animation = CAKeyframeAnimation.init(keyPath: "contents")
                animation.values = self.imageArray[index ?? 0]
                animation.duration = 0.8
                animation.calculationMode = .linear
                self.homeImageView.layer.add(animation, forKey: nil)
            }else{//非首页
                self.homeImageView.isHidden = true
                //遍历tabBarButton,找到UITabBarSwappableImageView
                for imageV in tabBarButton.subviews {
                    //图片
                    if imageV.isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                        //添加帧动画
                        let keyAnimation = CAKeyframeAnimation.init(keyPath: "contents")
                        keyAnimation.values = self.imageArray[index ?? 1]
                        keyAnimation.duration = 0.5
                        keyAnimation.calculationMode = .linear
                        imageV.layer.add(keyAnimation, forKey: nil)
                        //添加放大动画(时间极短)
                        //暂时不需要添加放大动画,将tabBarItem.selectedImage换成大图就可以了(跟UI商量好)
                        //let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
                        //scaleAnimation.duration = 0.1
                        //scaleAnimation.fromValue = NSNumber(value: 1.0)
                        //scaleAnimation.toValue = NSNumber(value: 1.2)
                        //scaleAnimation.fillMode = CAMediaTimingFillMode.forwards;
                        //scaleAnimation.isRemovedOnCompletion = true
                        //imageV.layer.add(scaleAnimation, forKey: "scale")
                    }
                }
            }
            //3、设置
            self.indexFlag = index ?? 0
        }
    }
}
