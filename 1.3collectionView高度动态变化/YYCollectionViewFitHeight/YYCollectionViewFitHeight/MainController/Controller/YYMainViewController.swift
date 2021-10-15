//
//  YYMainViewController.swift
//  YYCollectionViewFitHeight
//
//  Created by 杨世川 on 2021/10/13.
//

import UIKit

//MARK:- 常量 -
//MARK:屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
//MARK:屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class YYMainViewController: UIViewController {
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
        self.view.addSubview(self.listCollectionView)
        self.view.addSubview(self.backButton)
        self.listCollectionView.reloadData()
    }
    
    //布局子View
    func layoutViews() -> () {
        self.listCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(50)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.height.equalTo(1000)
        }
        self.backButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view).offset(-20)
            make.left.right.equalTo(self.view)
            make.height.equalTo(50)
        }
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    //MARK:点击按钮
    @objc func clickAddButton() -> () {
        //数据源添加数据
        let totalCount = self.dataSource.count
        for index in totalCount...(totalCount+1) {
            self.dataSource.append("\(index)-title")
        }
        //刷新列表
        self.listCollectionView.reloadData()
    }
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:数据源
    lazy var dataSource: Array<String> = {
        var dataSource = Array<String>()
        //添加数据源
        for index in 0...1{
            //let num = index / 2
            dataSource.append("\(index)-title")
        }
        return dataSource
    }()
    
    //MARK:flowLayout
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        let tempWidth = (SCREEN_WIDTH - 50)/2
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
        listCollectionView.layer.borderWidth = 1.0
        listCollectionView.layer.borderColor = UIColor.blue.cgColor
        listCollectionView.backgroundColor = UIColor.white
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(UINib.init(nibName: "YYCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "YYCollectionViewCell")
        return listCollectionView
    }()
    
    //MARK:返回上一层按钮
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("测试按钮", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(clickAddButton), for: .touchUpInside)
        return button
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
//MARK:UICollectionViewDelegate
extension YYMainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("willDisplay===========================P===1")
        print("将要展示的row=\(indexPath.row)")
        print("已经展示的lastRow=\(collectionView.indexPathsForVisibleItems.last?.row ?? -1)")
        print("当前已经展示的数组=\(collectionView.indexPathsForVisibleItems)")
        
        //这里可以根据列数,减少一次刷新次数(比如说这里是2列)
        if (indexPath.row + 1) % 2 == 1{//此时才刷新
            print("刷新YES")
            //动态设置CollectionView
            DispatchQueue.main.async {
                let contentSizeHeight = self.listCollectionView.contentSize.height
                self.listCollectionView.snp.updateConstraints { make in
                    make.height.equalTo(contentSizeHeight)
                }
            }
        }else{
            print("刷新NO")
        }
    }
}

//MARK:UICollectionViewDataSource
extension YYMainViewController: UICollectionViewDataSource{
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
