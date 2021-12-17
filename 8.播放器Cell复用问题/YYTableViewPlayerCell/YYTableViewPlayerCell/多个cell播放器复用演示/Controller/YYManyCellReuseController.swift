//
//  YYManyCellReuseController.swift
//  YYTableViewPlayerCell
//
//  Created by 杨世川 on 2021/12/13.
//

import UIKit
//MARK:- 常量 -
///最大y
var SPCMaxY: CGFloat = 0
///最小y
var SPCMinY: CGFloat = 0
///参考间距
let SPCMargin: CGFloat = 50

class YYManyCellReuseController: UIViewController {
    //MARK: - 属性 -
    ///可见cell(方案二)
    ///可见cell数组
    var playingCellArray: Array<SPCHomeListCollectionCell?> = Array<SPCHomeListCollectionCell?>()
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
        let cellArray = self.getAllVisiableCell()
        //2、添加playerView
        self.initPlayerView(cellArray: cellArray)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //遍历数组销毁播放器
        for playingCell in self.playingCellArray {
            if playingCell != nil {
                playingCell?.playerView?.closeTimer()
                playingCell?.playerView?.removeFromSuperview()
                playingCell?.playerView = nil
            }
        }
    }
    
    //MARK:初始化Views
    func initViews() -> () {
        self.title = "多个播放器"
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
        //1、数据源
        for index in 0..<5*15 {
            self.dataSource.append("\(index)---title")
        }
        //2、计算最大y和最小y
        SPCMinY = 0
        SPCMaxY = ScreenHeight - NavgationBarHeight - StatusBarHeight
        print("最大Y---\(SPCMaxY)----最小Y----\(SPCMinY)")
        //添加标签
        let minView = UIView.init(frame: CGRect.zero)
        minView.backgroundColor = UIColor.red
        self.view.addSubview(minView)
        minView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(SPCMinY)
            make.height.equalTo(5)
        }
        let maxView = UIView.init(frame: CGRect.zero)
        maxView.backgroundColor = UIColor.red
        self.view.addSubview(maxView)
        maxView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(SPCMaxY - 5)
            make.height.equalTo(5)
        }
    }
    
    //MARK: - Event Response -
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    //MARK:寻找所有可见cell
    func getAllVisiableCell() -> Array<SPCHomeListCollectionCell> {
        //1、获取所有可见cell
        let visiableCellArray = self.listCollectionView.visibleCells
        //2、转换成SPCHomeListCollectionCell,返回
        var resultArray = Array<SPCHomeListCollectionCell>()
        for cell in visiableCellArray {
            let tempCell = cell as! SPCHomeListCollectionCell
            print("可见cell------\(tempCell.nameLabel.text ?? "")")
            if self.judgeVisiablePosition(cell: tempCell) {
                resultArray.append(tempCell)
            }
        }
        //3、直接返回
        return resultArray
    }
    
    //MARK:进一步判断在可见区域的位置
    func judgeVisiablePosition(cell: SPCHomeListCollectionCell) ->Bool {
        //1、计算cell的中心点
        let cellCenter = cell.superview!.convert(cell.center, to: self.view)
        //2、判断中心点是否在SPCMinX和SPCMaxY之间
        if (cellCenter.y > SPCMinY) && (cellCenter.y < SPCMaxY) {
            print("区域-----Yes---\(cell.nameLabel.text ?? "")---\(cellCenter.y)")
            return true
        }else{
            print("区域-----No---\(cell.nameLabel.text ?? "")---\(cellCenter.y)")
            return false
        }
    }
    
    //MARK:初始化播放cell
    func initPlayerView(cellArray: Array<SPCHomeListCollectionCell>) -> () {
        //1、获取所有要播放的cell
        for cell in cellArray {
            //重新创建播放器
            let playView = YYPlayerView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            playView.nameLabel.text = cell.nameLabel.text
            playView.cellText = cell.nameLabel.text
            //添加到目标cell并保存cell
            cell.playerView = playView
            cell.addSubview(playView)
            //重新布局方便观察
            playView.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(0)
                make.bottom.equalToSuperview().offset(0)
                make.width.equalTo(100)
                make.height.equalTo(50)
            }
            self.playingCellArray.append(cell)
            //开始播放
            playView.beginTimer()
        }
    }
    
    //MARK:scrollView滚动的时候(只管停止播放,很重要,处理不好会影响复用)
    func scrollViewScroll() -> () {
        //获取当前可见的cell
        let visibleCellArray = self.getAllVisiableCell()
        //visibleCellArray和playingCellArray对比
        self.playingCellArray = self.playingCellArray.filter { playingCell in
            if playingCell != nil{
                if !visibleCellArray.contains(playingCell!) {//不包含
                    //播放器销毁
                    playingCell?.playerView?.closeTimer()
                    playingCell?.playerView?.removeFromSuperview()
                    playingCell?.playerView = nil
                    //移出cell
                    return false
                }
            }
            return true
        }
        print("当前数组更新===========P")
        print(self.playingCellArray.count)
    }
    
    //MARK:scrollView滚动停止(创建播放器)
    func scrollViewStop() -> () {
        //获取当前可见的cell
        let visibleCellArray = self.getAllVisiableCell()
        //visibleCellArray和playingCellArray对比
        var resultArray = Array<SPCHomeListCollectionCell>()
        for newCell in visibleCellArray {
            if !self.playingCellArray.contains(newCell) {//不是同一个才重新创建
                print("NO是同一个不用创建===========P")
                //进一步销毁播放器
                if newCell.playerView != nil {
                    newCell.playerView?.closeTimer()
                    newCell.playerView?.removeFromSuperview()
                    newCell.playerView = nil
                }
                //添加数组
                resultArray.append(newCell)
            }else{
                print("YES是同一个不用创建===========P")
            }
        }
        //整体创建播放器
        self.initPlayerView(cellArray: resultArray)
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
extension YYManyCellReuseController: UIScrollViewDelegate{
    //开始滚动(只做销毁,当滑动停止的时候才创建)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollViewScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //如果手指一直拖着,这个时候不会惯性滑动,不会走scrollViewDidEndDecelerating方法
        if !decelerate {
            print("停止Drag============+P---\(decelerate)")
            self.scrollViewStop()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("停止滚动============+P")
        //停止滚动找出第一个,让第一个cell添加PlayerView
        self.scrollViewStop()
    }
}

//MARK:UICollectionViewDelegate
extension YYManyCellReuseController: UICollectionViewDelegate{
    
}

//MARK:UICollectionViewDataSource
extension YYManyCellReuseController: UICollectionViewDataSource{
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
