//
//  YYCustomFlowLayoutController.swift
//  YYCollectionViewScroll
//
//  Created by 杨世川 on 2021/10/13.
//

import UIKit

class YYCustomFlowLayoutController: UIViewController {
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
        self.title = "自定义FlowLayout"
        
        self.view.addSubview(self.listCollectionView)
        self.listCollectionView.reloadData()
    }
    
    //布局子View
    func layoutViews() -> () {
        self.listCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(300)
            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(YYCellHeight)
        }
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:数据源
    lazy var dataSource: Array<String> = {
        var dataSource = Array<String>()
        //添加数据源
        for index in 0...15*5{
            if index % 2 == 0 {
                dataSource.append("\(index)-title22")
            }else if index % 3 == 0 {
                dataSource.append("\(index)-title333")
            }else{
                dataSource.append("\(index)-title")
            }
        }
        return dataSource
    }()
    
    //MARK:flowLayout
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize(width: CGFloat(YYCellWidth), height: CGFloat(YYCellHeight))
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
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
//MARK:
extension YYCustomFlowLayoutController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //计算文本大小
        let titleString = self.dataSource[indexPath.row]
        let size = titleString.getStringSizeFromBoundingRect(font: UIFont.systemFont(ofSize: 16.0))
        return CGSize(width: size.width + 10, height: CGFloat(YYCellHeight))
    }
}

//MARK:UICollectionViewDelegate
extension YYCustomFlowLayoutController: UICollectionViewDelegate{
    
}

//MARK:UICollectionViewDataSource
extension YYCustomFlowLayoutController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: "YYCollectionViewCell", for: indexPath) as! YYCollectionViewCell
        let title = self.dataSource[indexPath.row]
        cell.label.text = title
        return cell
    }
}


