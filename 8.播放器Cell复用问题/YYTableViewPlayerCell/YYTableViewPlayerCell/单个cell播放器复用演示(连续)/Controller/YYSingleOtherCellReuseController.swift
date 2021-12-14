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
    var playingCell: SPCHomeListCollectionCell?
    ///播放器View
    var playerView: YYPlayerView?
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
        //1、获取第一个Cell
        let firstCell = self.getFirstVisiableCell()
        //2、添加playerView
        self.initPlayerView(cell: firstCell)
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
    //MARK:寻找可见cell的第一个
    func getFirstVisiableCell() -> SPCHomeListCollectionCell {
        //1、获取所有可见cell
        let visiableCellArray = self.listCollectionView.visibleCells
        //2、寻找最小index
        var minIndex = 100
        for cell in visiableCellArray {
            let tempCell = cell as! SPCHomeListCollectionCell
            let indexPath = self.listCollectionView.indexPath(for: tempCell)
            if (indexPath?.row ?? 0) < minIndex{
                minIndex = indexPath?.row ?? 0
            }
        }
        //3、重新获取cell
        let targetCell = self.listCollectionView.cellForItem(at: IndexPath(row: minIndex, section: 0))
        return targetCell as! SPCHomeListCollectionCell
    }
    
    //MARK:初始化播放cell
    func initPlayerView(cell: SPCHomeListCollectionCell) -> () {
        //测试变量
        SPCGlobalTimeCount += 1
        
        //1、指向cell
        self.playingCell = cell
        //2、销毁播放器
        self.playerView?.closeTimer()
        self.playerView = nil
        //重新创建播放器
        let playView = YYPlayerView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        playView.nameLabel.text = "测试复用========="
        self.playerView = playView
        //添加到cell
        cell.addSubview(playView)
        //playerView播放
        playView.beginTimer()
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
        let visibleCellArray = self.listCollectionView.visibleCells
        //判断playingCell是否为nil(界面没有加载出来的时候,没有playingCell)
        guard self.playingCell != nil else {
            return
        }
        //判断visibleCellArray是否包含playingCell
        if !visibleCellArray.contains(self.playingCell!) {//不包含销毁播放器
            if self.playerView != nil {//播放器也不为nil
                self.playerView?.closeTimer()
                self.playerView?.removeFromSuperview()
                self.playerView = nil
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("停止Drag============+P---\(decelerate)")
        //如果手指一直拖着,这个时候不会惯性滑动,不会走scrollViewDidEndDecelerating方法
        if !decelerate {
            //获取第一个cell
            let firstCell = self.getFirstVisiableCell()
            //要判断firstCell是否等于playingCell
            if firstCell != self.playingCell {//不是同一个才重新创建
                //销毁播放器
                if self.playerView != nil {
                    self.playerView?.closeTimer()
                    self.playerView?.removeFromSuperview()
                    self.playerView = nil
                }
                //创建播放器
                self.initPlayerView(cell: firstCell)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("停止滚动============+P")
        //停止滚动找出第一个,让第一个cell添加PlayerView
        //获取第一个cell
        let firstCell = self.getFirstVisiableCell()
        //要判断firstCell是否等于playingCell
        if firstCell != self.playingCell {//不是同一个才重新创建
            //销毁播放器
            if self.playerView != nil {
                self.playerView?.closeTimer()
                self.playerView?.removeFromSuperview()
                self.playerView = nil
            }
            //创建播放器
            self.initPlayerView(cell: firstCell)
        }
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
