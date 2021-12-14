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
        self.view.addSubview(self.centerView)
    }
    
    //布局子View
    func layoutViews() -> () {
        self.listCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.centerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
            make.width.height.equalTo(10)
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
    
    //MARK:获取可见cells中距离屏幕中心最近的cell
    func getCenterCell() -> SPCHomeListCollectionCell? {
        //1、获取所有可见cell
        let visiableCellArray = self.listCollectionView.visibleCells
        //2、寻找距离最短的
        var targetCell: SPCHomeListCollectionCell?
        var minDistance = MAXFLOAT
        for cell in visiableCellArray {
            //映射到屏幕中位置
            //let cellCenter = cell.superview!.convert(cell.center, to: nil)
            let cellCenter = cell.superview!.convert(cell.center, to: self.view)
            let delta = abs(cellCenter.y - self.centerView.center.y)
            print("中心位置-----1---\(String(describing: self.listCollectionView.indexPath(for: cell)))---\(cellCenter.y)---\(delta)")
            if delta < CGFloat(minDistance) {
                minDistance = Float(delta)
                targetCell = cell as? SPCHomeListCollectionCell
            }
        }
        print("中心位置---2---\(String(describing: self.listCollectionView.indexPath(for: targetCell!)))")
        return targetCell
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
    
    //MARK:添加一个中心点
    lazy var centerView: UIView = {
        let centerView = UIView.init(frame: CGRect.zero)
        centerView.backgroundColor = UIColor.green
        return centerView
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
            //这里记住也要将playingCell置为nil,否则出现复用导致异常
            //可以快速滑动验证,这样可以很快出现复用
            self.playingCell = nil
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //如果手指一直拖着,这个时候不会惯性滑动,不会走scrollViewDidEndDecelerating方法
        if !decelerate {
            print("停止Drag============+P---\(decelerate)")
            //获取第一个cell
            //let firstCell = self.getFirstVisiableCell()
            let firstCell = self.getCenterCell()
            //要判断firstCell是否等于playingCell
            if firstCell != self.playingCell {//不是同一个才重新创建
                //销毁播放器
                if self.playerView != nil {
                    self.playerView?.closeTimer()
                    self.playerView?.removeFromSuperview()
                    self.playerView = nil
                }
                //创建播放器
                if firstCell != nil {
                    self.initPlayerView(cell: firstCell!)
                }
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("停止滚动============+P")
        //停止滚动找出第一个,让第一个cell添加PlayerView
        //获取第一个cell
        //let firstCell = self.getFirstVisiableCell()
        let firstCell = self.getCenterCell()
        //要判断firstCell是否等于playingCell
        if firstCell != self.playingCell {//不是同一个才重新创建
            //销毁播放器
            if self.playerView != nil {
                self.playerView?.closeTimer()
                self.playerView?.removeFromSuperview()
                self.playerView = nil
            }
            //创建播放器
            if firstCell != nil {
                self.initPlayerView(cell: firstCell!)
            }else{
                print("是nil===========不用创建")
            }
        }else{
            print("是同一个===========不用创建")
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

//MARK:代码逻辑
//1、获取visibleCells,并获取第一个cell
//2、self.playingCell指向第一个cell,CLPlayerView销毁重新生成一个,并添加到cell,并用_clPlayerView指向它
//3、滚动时---scrollViewDidScroll
//    时刻监听正在播放的cell是否被移除界面
//    scrollViewDidScroll---获取当前可见cell,判断可见cells里面是否包含playingCell,不包含的话,说明已经移出界面,此时应该销毁播放器.(这里要判断playingCell和_clPlayerView是否为nil)
//4、滚动暂停
//     重新寻找cell,开始播放
//     前面是直接播放第一个cell,后面滚动停止的时候,找中心点距离屏幕中心最近的
//     (我们这里永远播放可见cell的第一个)
//
//     还要判断找到的cell不能等于playingCell(当然了也不能等于nil)
//     找到以后➡️销毁播放器➡️重新使用上面的方法initPlayerView,生成播放器_clPlayerView➡️playingCell指向新找到的cell
