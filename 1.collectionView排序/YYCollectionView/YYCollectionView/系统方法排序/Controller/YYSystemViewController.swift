//
//  YYSystemViewController.swift
//  YYCollectionView
//
//  Created by 杨世川 on 2021/9/23.
//

import UIKit

//MARK:- 常量 -

class YYSystemViewController: UIViewController {
    //MARK: - 属性 -
    //MARK:oldIndexPath(这个主要用来辨别是否有cell被长按,不需要更新位置)
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
        //1、在collectionview添加长按手势
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressEvent))
        self.listCollectionView.addGestureRecognizer(longPress)
    }
    
    //MARK: - Event Response -
    //MARK:处理长按手势
    @objc func longPressEvent(longPress: UILongPressGestureRecognizer) -> () {
        //获取长按点位置
        let point = longPress.location(in: self.listCollectionView)
        
        //手势处理
        switch longPress.state {
        case .began://手势开始
            let indexPath = self.listCollectionView.indexPathForItem(at: point)
            if indexPath == nil {
                return
            }
            self.dragingIndexPath = indexPath
            //iOS9以上移动cell方法
            self.listCollectionView.beginInteractiveMovementForItem(at: indexPath!)
            break
        case .changed://手势移动
            if self.dragingIndexPath == nil {
                return
            }
            //更新Cell位置
            self.listCollectionView.updateInteractiveMovementTargetPosition(point)
            break
        case .ended://手势结束
            if self.dragingIndexPath == nil {
                return
            }
            //cell结束移动
            self.listCollectionView.endInteractiveMovement()
            self.dragingIndexPath = nil
            break
        default:
            if self.dragingIndexPath == nil {
                return
            }
            //cell取消移动
            self.listCollectionView.cancelInteractiveMovement()
            self.dragingIndexPath = nil
            break
        }
    }
    
    //MARK:点击系统方法
    @objc func clickBackButton() -> () {
        self.dismiss(animated: true) {
            
        }
    }
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:数据源
    lazy var dataSource: Array<String> = {
        var dataSource = Array<String>()
        //添加数据源
        for index in 0...15*5{
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
extension YYSystemViewController: UICollectionViewDelegate{
    
}

//MARK:UICollectionViewDataSource
extension YYSystemViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: "YYCollectionViewCell", for: indexPath) as! YYCollectionViewCell
        let title = self.dataSource[indexPath.row]
        cell.label.text = title
        return cell
    }
    
    //MARK:允许移动
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //移动结束会调用此方法,会重新读取数据源数据
    //所以要处理数据源数据
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //获取移动row中数据
        let sourceTitle = self.dataSource[sourceIndexPath.row]
        //数据源移除该数据
        self.dataSource.remove(at: sourceIndexPath.row)
        //插入目标位置
        self.dataSource.insert(sourceTitle, at: destinationIndexPath.row)
    }
}

