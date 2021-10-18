//
//  YYCollectionViewCell.swift
//  YYCollectionView
//
//  Created by 杨世川 on 2021/10/8.
//

import UIKit

class YYCollectionViewCell: UICollectionViewCell {
    //MARK:- 属性 -
    //MARK:标题
    @IBOutlet weak var titleLabel: UILabel!
    //MARK:展开按钮
    @IBOutlet weak var openButton: UIButton!
    //MARK:显示子设备按钮
    @IBOutlet weak var showSubDeviceButton: UIButton!
    //MARK:列表
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    //MARK:布局
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    //MARK:图片
    @IBOutlet weak var coverImageView: UIImageView!
    
    //MARK:模型
    var deviceModel: YYDeviceModel?
    //MARK:IndexPath
    var indexPath: IndexPath?
    //MARK:UICollectionView
    var parentCollectionView: UICollectionView?
    
    //MARK:- Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置边界颜色
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
        //设置CollectionView
        self.buttonCollectionView.bounces = false
        self.buttonCollectionView.isScrollEnabled = false
        self.buttonCollectionView.delegate = self
        self.buttonCollectionView.dataSource = self
        self.buttonCollectionView.register(UINib.init(nibName: "YYCollectionViewSubCell", bundle: nil), forCellWithReuseIdentifier: "YYCollectionViewSubCell")
        //设置flowLayout参数
        self.flowLayout.minimumLineSpacing = 0.0
        self.flowLayout.minimumInteritemSpacing = 0.0
        self.flowLayout.scrollDirection = .vertical
        self.flowLayout.itemSize = CGSize(width: SCREEN_WIDTH/2, height: 90)
    }
    
    //MARK:- Event Response -
    //MARK:点击显示子设备按钮
    @IBAction func clickShowDeviceButton(_ sender: UIButton) {
        self.deviceModel?.isShowSubDevice = !(self.deviceModel?.isShowSubDevice ?? false)
        if !(self.deviceModel?.isShowSubDevice ?? false) {
            self.deviceModel?.isOpenSubDevice = false
        }
        self.parentCollectionView?.reloadItems(at: [self.indexPath!])
    }
    
    //MARK:点击展开按钮
    @IBAction func clickOpenButton(_ sender: UIButton) {
        //判断是否显示了子设备
        if self.deviceModel?.isShowSubDevice ?? false {
            self.deviceModel?.isOpenSubDevice = !(self.deviceModel?.isOpenSubDevice ?? false)
            //这里要重新计算当前cell高度
            self.calculateCellHeight()
            self.parentCollectionView?.reloadItems(at: [self.indexPath!])
        }
    }
    
    //MARK:- Public Methods -
    //MARK:设置模型
    func setDeviceModel(deviceModel: YYDeviceModel,
                        indexPath: IndexPath,
                        collectionView: UICollectionView) -> () {
        //赋值
        self.deviceModel = deviceModel
        self.indexPath = indexPath
        self.parentCollectionView = collectionView
        //处理显示
        self.titleLabel.text = deviceModel.deviceName
        //是否显示子设备
        if self.deviceModel?.isShowSubDevice ?? false {
            self.coverImageView.isHidden = true
        }else{
            self.coverImageView.isHidden = false
        }
        //刷新列表
        self.buttonCollectionView.reloadData()
    }
    
    //MARK:- Private Methods -
    //MARK:计算Cell的高度
    func calculateCellHeight() -> () {
        var height = 210
        if self.deviceModel?.isOpenSubDevice ?? false {
            let subDeviceCount = self.deviceModel?.subDeviceCount ?? 0
            if subDeviceCount > 4 {
                let tempCount = subDeviceCount - 4
                let tempHeight = (tempCount % 2) + (tempCount / 2)
                height += tempHeight * 90
            }
        }
        self.deviceModel?.subCollectionViewHeight = height
    }
}

//MARK: - SystemDelegate -
//MARK:UICollectionViewDelegate
extension YYCollectionViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}

//MARK:UICollectionViewDataSource
extension YYCollectionViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //这里判断是不是NVR,再判断是不是需要展开.否则返回0(后续逻辑)
        //不返回0的话,会频繁刷新,不可取
        //return 0
        //这里是子设备的数量
        if self.deviceModel?.isShowSubDevice ?? false{
            return self.deviceModel?.subDeviceCount ?? 0
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.buttonCollectionView.dequeueReusableCell(withReuseIdentifier: "YYCollectionViewSubCell", for: indexPath) as! YYCollectionViewSubCell
        return cell
    }
}
