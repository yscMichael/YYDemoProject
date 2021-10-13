//
//  YYMainViewController.swift
//  YYCollectionViewScroll
//
//  Created by 杨世川 on 2021/9/24.
//

import UIKit

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
        
    }
    
    //布局子View
    func layoutViews() -> () {
        
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
    lazy var sourceArr: Array<String> = {
        let sourceArr = ["0000000",
                         "111111",
                         "2222",
                         "333",
                         "433",
                         "6665",
                         "3336",
                         "117",
                         "324242",
                         "555555",
                         "5464646464",
                         "353353535353535"]
        return sourceArr
    }()
    
    //MARK:布局
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize(width: 130, height: 130)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 2
        return flowLayout
    }()
    
    //MARK:collectionView
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 244, width: self.view.frame.size.width, height: 30), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        //collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        
        return collectionView
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
//MARK:UICollectionViewDelegate
extension YYMainViewController: UICollectionViewDelegate{
    
}

//MARK:UICollectionViewDataSource
//extension YYMainViewController: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
