//
//  YYCustomViewController.swift
//  YYCollectionView
//
//  Created by 杨世川 on 2021/10/8.
//

import UIKit

class YYCustomRealCellController: UIViewController {
    //MARK: - 属性 -
    //MARK:oldIndexPath(这个主要用来辨别是否有cell被长按,同时需要更新位置)
    var dragingIndexPath: IndexPath?
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.layoutViews()
        self.initData()
    }
    
    //MARK:初始化Views
    func initViews() -> () {
        self.view.addSubview(self.listCollectionView)
        self.view.addSubview(self.backButton)
        self.listCollectionView.reloadData()
    }
    
    //布局子View
    func layoutViews() -> () {
        self.listCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        self.backButton.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(self.view)
            make.height.equalTo(50)
        }
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    //MARK:处理长按手势
    @objc func longPressEvent(longPress: UILongPressGestureRecognizer) -> () {
        //将点映射到listCollectionView
        let point = longPress.location(in: self.listCollectionView)
        //获取cell
        let cell = longPress.view as! YYCollectionViewCell
        self.listCollectionView.bringSubviewToFront(cell)
        
        //手势处理
        switch longPress.state {
        case .began://手势开始
            //获取对应cell的位置
            let indexPathT = self.listCollectionView.indexPath(for: cell)
            if indexPathT == nil {
                return
            }
            self.dragingIndexPath = indexPathT
            //获取当前所有Cell的位置信息
            self.cellAttributesArray.removeAll()
            for index in 0..<self.dataSource.count {
                let attributes = self.listCollectionView.layoutAttributesForItem(at: IndexPath(row: index, section: 0))
                self.cellAttributesArray.append(attributes!)
            }
            break
        case .changed://手势移动
            if self.dragingIndexPath == nil {
                return
            }
            //更新Cell位置
            cell.center = point
            //判断是否需要交换cell
            for attributes in self.cellAttributesArray {
                if attributes.frame.contains(point) &&
                    (self.dragingIndexPath != attributes.indexPath) {
                    //修改数据源
                    let orginalTitle = self.dataSource[self.dragingIndexPath!.row]
                    self.dataSource.remove(at: self.dragingIndexPath!.row)
                    self.dataSource.insert(orginalTitle, at: attributes.indexPath.row)
                    //交换位置
                    self.listCollectionView.moveItem(at: self.dragingIndexPath!, to: attributes.indexPath)
                    //拖动位置重新赋值
                    self.dragingIndexPath = attributes.indexPath
                }
            }
            break
        case .ended://手势结束
            if self.dragingIndexPath == nil {
                return
            }
            //cell结束移动
            guard let attributes = self.listCollectionView.layoutAttributesForItem(at: self.dragingIndexPath!) else {
                self.dragingIndexPath = nil
                return
            }
            cell.center = attributes.center
            self.dragingIndexPath = nil
            break
        default:
            self.dragingIndexPath = nil
            break
        }
    }
    
    //MARK:点击返回方法
    @objc func clickBackButton() -> () {
        //测试moveItemAtIndexPath:toIndexPath:方法
        //self.listCollectionView.moveItem(at: IndexPath.init(row: 0, section: 0), to: IndexPath.init(row: 1, section: 0))
        //print("打印数据源")
        //print(self.dataSource)
        
        //返回上一级
        self.dismiss(animated: true) {
        
        }
    }
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:所有cell位置信息
    lazy var cellAttributesArray: Array<UICollectionViewLayoutAttributes> = {
        let cellAttributesArray = Array<UICollectionViewLayoutAttributes>()
        return cellAttributesArray
    }()
    
    //MARK:Cell数据源
    lazy var dataSource: Array<String> = {
        var dataSource = Array<String>()
        //添加数据源
        for index in 0...150{
            dataSource.append("\(index)-title")
        }
        return dataSource
    }()
    
    //MARK:flowLayout
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        let tempWidth = (SCREEN_WIDTH - 50)/4
        let tempHeight = 85
        flowLayout.itemSize = CGSize(width: tempWidth, height: CGFloat(tempHeight))
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0.1
        return flowLayout
    }()
    
    //MARK:UICollectionView
    lazy var listCollectionView: UICollectionView = {
        let listCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        listCollectionView.backgroundColor = UIColor.white
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(UINib.init(nibName: "YYCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "YYCollectionViewCell")
        return listCollectionView
    }()
    
    //MARK:返回上一层按钮
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("返回", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(clickBackButton), for: .touchUpInside)
        return button
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
//MARK:UICollectionViewDelegate
extension YYCustomRealCellController: UICollectionViewDelegate{
    
}

//MARK:UICollectionViewDataSource
extension YYCustomRealCellController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: "YYCollectionViewCell", for: indexPath) as! YYCollectionViewCell
        //赋值
        let title = self.dataSource[indexPath.row]
        cell.label.text = title
        //添加手势(不能添加到collectionView)
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressEvent))
        cell.addGestureRecognizer(longPress)
        return cell
    }
}
