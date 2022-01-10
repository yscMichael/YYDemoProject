//
//  ViewController.swift
//  YYMaskLayer
//
//  Created by 杨世川 on 2022/1/8.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - 属性 -
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.layoutViews()
        self.initData()
    }
    
    //MARK:初始化Views
    func initViews() -> () {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.bottomImageView)
        //测试贝塞尔曲线
        //self.testAppendPath()
        //圆形镂空
        //self.addUIBezierPathZero()
        //矩形镂空
        //self.addUIBezierPathRect()
        //多个点镂空
        self.addUIBezierPathMany()
    }
    
    //布局子View
    func layoutViews() -> () {
        self.bottomImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    //MARK:测试appendPath
    func testAppendPath() -> () {
        //绘制贝塞尔曲线
        //1、绘制一个矩形
        let rectPath = UIBezierPath.init(rect: self.view.bounds)
        //2、绘制一个圆形(clockwise: false/true)
        let zeroPath = UIBezierPath.init(arcCenter: self.view.center, radius: 50, startAngle: 0, endAngle: 2*CGFloat(Double.pi), clockwise: false)
        //3、拼接(是否append)
        rectPath.append(zeroPath)
        //4、显示
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.path = rectPath.cgPath
        shapeLayer.lineWidth = 20
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.yellow.cgColor
        self.view.layer.addSublayer(shapeLayer)
    }
    
    //MARK:添加贝塞尔曲线(圆角镂空)
    func addUIBezierPathZero() -> () {
        //添加遮罩
        let maskView = UIView.init(frame: self.view.bounds)
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.8
        self.view.addSubview(maskView)
        //绘制贝塞尔曲线
        //1、绘制一个矩形
        let rectPath = UIBezierPath.init(rect: self.view.bounds)
        //2、绘制一个圆形
        let zeroPath = UIBezierPath.init(arcCenter: maskView.center, radius: 50, startAngle: 0, endAngle: 2*CGFloat(Double.pi), clockwise: false)
        //3、拼接
        rectPath.append(zeroPath)
        //4、设置maskLayer
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = rectPath.cgPath
        //5、mask设置
        maskView.layer.mask = maskLayer
    }
    
    //MARK:长方形镂空
    func addUIBezierPathRect() -> () {
        //添加遮罩
        let maskView = UIView.init(frame: self.view.bounds)
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.8
        self.view.addSubview(maskView)
        //绘制贝塞尔曲线
        //1、绘制一个矩形
        let rectPath = UIBezierPath.init(rect: self.view.bounds)
        //2、添加一个长方形
        let rectPathOne = UIBezierPath.init(rect: CGRect(x: 100, y: 100, width: 200, height: 50)).reversing()
        //3、拼接
        rectPath.append(rectPathOne)
        //4、设置maskLayer
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = rectPath.cgPath
        //5、mask设置
        maskView.layer.mask = maskLayer
    }
    
    //MARK:多个点镂空(setUsesEvenOddFillRule)
    func addUIBezierPathMany() -> () {
        //添加遮罩
        let maskView = UIView.init(frame: self.view.bounds)
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.8
        self.view.addSubview(maskView)
        //整体区域
        let bezierPath = UIBezierPath.init(rect: self.view.bounds)
        //指定区域1(这里不用反转区域)
        let rect1 = UIBezierPath.init(rect: CGRect(x: 100, y: 100, width: 200, height: 50))
        bezierPath.append(rect1)
        //指定区域2(这里false和true都不影响)
        let rect2 = UIBezierPath.init(arcCenter: maskView.center, radius: 50, startAngle: 0, endAngle: 2*CGFloat(Double.pi), clockwise: true)
        bezierPath.append(rect2)
        //奇偶原则
        bezierPath.usesEvenOddFillRule = true
        //4、设置maskLayer
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = bezierPath.cgPath
        maskLayer.fillRule = .evenOdd
        //5、mask设置
        maskView.layer.mask = maskLayer
    }
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:底部图片
    lazy var bottomImageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage(named: "Advertisement")!)
        return imageView
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -

