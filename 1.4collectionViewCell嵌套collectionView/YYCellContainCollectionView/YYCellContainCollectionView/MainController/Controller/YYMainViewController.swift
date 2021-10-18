//
//  YYMainViewController.swift
//  YYCellContainCollectionView
//
//  Created by 杨世川 on 2021/10/18.
//

import UIKit

//MARK:- 常量 -
//MARK:屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
//MARK:屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class YYMainViewController: UIViewController {
    //MARK: - 属性 -
    //MARK:数据源
    lazy var dataSource: Array<YYDeviceModel> = Array<YYDeviceModel>()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.layoutViews()
        self.initData()
    }
    
    //MARK:初始化Views
    func initViews() -> () {
        self.title = "测试cell嵌套collectionView"
        self.view.backgroundColor = UIColor.green
        self.view.addSubview(self.listCollectionView)
        self.listCollectionView.reloadData()
    }
    
    //布局子View
    func layoutViews() -> () {
        self.listCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(0)
            make.left.right.bottom.equalTo(self.view).offset(0)
        }
    }
    
    //初始化数据
    func initData() -> () {
        //1、初始化模型数据
        for index in 0...10{
            let deviceModel = YYDeviceModel()
            deviceModel.deviceName = "\(index)-title"
            deviceModel.iotId = "\(index)-iotId"
            deviceModel.subDeviceCount = index + 1
            deviceModel.subCollectionViewHeight = 210
            self.dataSource.append(deviceModel)
        }
        self.listCollectionView.reloadData()
    }
    
    //MARK: - Event Response -
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:flowLayout
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        let tempWidth = SCREEN_WIDTH
        let tempHeight = 210
        flowLayout.itemSize = CGSize(width: tempWidth, height: CGFloat(tempHeight))
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }()
    
    //MARK:UICollectionView
    lazy var listCollectionView: UICollectionView = {
        let listCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        listCollectionView.layer.borderWidth = 1.0
        listCollectionView.layer.borderColor = UIColor.blue.cgColor
        listCollectionView.backgroundColor = UIColor.white
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(UINib.init(nibName: "YYCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "YYCollectionViewCell")
        return listCollectionView
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
//MARK:UICollectionViewDelegateFlowLayout
extension YYMainViewController: UICollectionViewDelegateFlowLayout{
    //MARK:这里不要每次都计算,最好把数据源计算好
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceModel = self.dataSource[indexPath.row]
        return CGSize(width: SCREEN_WIDTH, height: CGFloat(deviceModel.subCollectionViewHeight))
    }
}

//MARK:UICollectionViewDelegate
extension YYMainViewController: UICollectionViewDelegate{
    
}

//MARK:UICollectionViewDataSource
extension YYMainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: "YYCollectionViewCell", for: indexPath) as! YYCollectionViewCell
        let deviceModel = self.dataSource[indexPath.row]
        cell.setDeviceModel(deviceModel: deviceModel,indexPath: indexPath,collectionView: self.listCollectionView)
        return cell
    }
}
