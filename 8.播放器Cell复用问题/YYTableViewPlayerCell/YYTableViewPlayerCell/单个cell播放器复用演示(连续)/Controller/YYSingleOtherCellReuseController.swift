//
//  YYSingleOtherCellReuseController.swift
//  YYTableViewPlayerCell
//
//  Created by 杨世川 on 2021/12/13.
//

import UIKit

class YYSingleOtherCellReuseController: UIViewController {
    //MARK: - 属性 -
    ///可见cell(方案一)
    var visibleFirstCell: SPCHomeListCollectionCell?
    ///数据源
    var dataSource: Array<String> = Array<String>()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.layoutViews()
        self.initData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //1、界面显示的时候才开始播放(界面未显示没必要播放)
        //这里开始查找可以看见的cell,然后添加播放器View
        let array = self.listCollectionView.visibleCells
        print("viewDidAppear============+P---\(array.count)")
        //2、获取第一个cell,添加playerView
        let firstCell = array.first as! SPCHomeListCollectionCell
        self.createPlayView(cell: firstCell)
        //3、指针指向,方便后续对比
        self.visibleFirstCell = firstCell
    }
    
    //MARK:初始化Views
    func initViews() -> () {
        self.title = "主控制器"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.addSubview(self.listCollectionView)
    }
    
    //布局子View
    func layoutViews() -> () {
        self.listCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //初始化数据
    func initData() -> () {
        for index in 0..<5*15 {
            self.dataSource.append("\(index)---title")
        }
    }
    
    //MARK: - Event Response -
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    //MARK:创建播放器并进行添加
    func createPlayView(cell: SPCHomeListCollectionCell) -> () {
        //1、创建View
        let playeView = YYPlayerView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        playeView.nameLabel.text = "测试复用========="
        cell.playerView = playeView
        cell.addSubview(playeView)
        //2、定时器变量加1
        SPCGlobalTimeCount += 1
    }
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:flowLayout
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        let tempWidth = ScreenWidth - 20
        let tempHeight = 160
        flowLayout.itemSize = CGSize(width: tempWidth, height: CGFloat(tempHeight))
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 0.1
        return flowLayout
    }()
    
    //MARK:UICollectionView
    lazy var listCollectionView: UICollectionView = {
        let listCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        listCollectionView.backgroundColor = UIColor.white
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(SPCHomeListCollectionCell.self, forCellWithReuseIdentifier: "SPCHomeListCollectionCell")
        //设置边界颜色
        listCollectionView.layer.borderColor = UIColor.blue.cgColor
        listCollectionView.layer.borderWidth = 3.0
        return listCollectionView
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
//MARK:UICollectionViewDelegate
extension YYSingleOtherCellReuseController: UIScrollViewDelegate{
    //开始滚动(只做销毁,当滑动停止的时候才创建)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取可见的cell
        let tempArrayCell = self.listCollectionView.visibleCells
        print("开始滚动============+P---\(tempArrayCell.count)")
        //判断是否包含visibleFirstCell
        if self.visibleFirstCell != nil {//判断是否有可见cell
            print("开始滚动============+P---visibleFirstCell不为nil----1")
            if !tempArrayCell.contains(self.visibleFirstCell!) {//不包含的话,做销毁处理
                print("开始滚动============+P---visibleFirstCell不可见---2---\(self.visibleFirstCell?.nameLabel.text ?? "为空")")
                if self.visibleFirstCell?.playerView != nil {
                    print("开始滚动============+P---visibleFirstCell有playerView---3")
                    //先停止播放器
                    self.visibleFirstCell?.playerView?.testTimer?.invalidate()
                    self.visibleFirstCell?.playerView?.testTimer = nil
                    self.visibleFirstCell?.playerView?.removeFromSuperview()
                    self.visibleFirstCell?.playerView = nil
                }else{
                    print("开始滚动============+P---visibleFirstCell销毁playerView---4")
                }
            }
        }else{
            print("开始滚动============+P---visibleFirstCell为nil")
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //print("停止Drag============+P---\(decelerate)")
        //如果手指一直拖着,这个时候不会惯性滑动,不会走scrollViewDidEndDecelerating方法
        if !decelerate {
            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("停止滚动============+P")
        //停止滚动找出第一个,让第一个cell添加PlayerView
    }
}

//MARK:UICollectionViewDelegate
extension YYSingleOtherCellReuseController: UICollectionViewDelegate{
    
}

//MARK:UICollectionViewDataSource
extension YYSingleOtherCellReuseController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: "SPCHomeListCollectionCell", for: indexPath) as! SPCHomeListCollectionCell
        //模型赋值
        let title = self.dataSource[indexPath.row]
        cell.nameLabel.text = title
        return cell
    }
}
