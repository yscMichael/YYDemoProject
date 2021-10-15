//
//  YYLineFlowOneLayout.swift
//  YYCollectionViewScroll
//
//  Created by 杨世川 on 2021/10/13.
//

import UIKit

protocol SPCCustomFlowLayoutDelegate: NSObjectProtocol {
    //获取每一项的大小
    func getItemSize(indexPath: IndexPath) -> (CGSize)
}

class YYLineFlowOneLayout: UICollectionViewFlowLayout {
    //最大X
    var maxX = 0
    //cell的所有属性数组
    var allAttributesArray: Array<UICollectionViewLayoutAttributes> = Array<UICollectionViewLayoutAttributes>()
    //代理
    weak var delegate: SPCCustomFlowLayoutDelegate?
}

//MARK:流水布局实现下面三种方法
extension YYLineFlowOneLayout{
    //MARK:1
    //MARK:设置为true,collectionView一旦滑动就会调用prepare和layoutAttributesForElements
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //MARK:2
    //MARK:一些初始化工作最好在这里实现(此时collectionView的frame已完成)
    override func prepare() {
        super.prepare()
        print("prepare==========P")
        if self.allAttributesArray.count != 0 {
            return
        }
        self.allAttributesArray.removeAll()
        //1、获取所有属性
        //(因为系统获取的永远是没有改变的,必须自己拷贝一份,否则即使计算正确,界面也很容易发生错乱跳变)
        let count = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        for index in 0..<count {
            let attrs = self.collectionView?.layoutAttributesForItem(at: IndexPath(item: index, section: 0))
            if attrs != nil {
                self.allAttributesArray.append(attrs!)
            }
        }
        print("数组数量=\(self.allAttributesArray.count)")
    }
    
    //MARK:3
    //MARK:重新计算allAttributesArray里面的数值(主要是frame)
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("layoutAttributesForElements==========P")
        //最终返回的数组
        var resultArray = Array<UICollectionViewLayoutAttributes>()
        //1、获取当前屏幕可见区域
        let x = self.collectionView?.contentOffset.x ?? 0
        let y = self.collectionView?.contentOffset.y ?? 0
        let width = self.collectionView?.frame.size.width ?? 0
        let height = self.collectionView?.frame.size.height ?? 0
        let visiableRect = CGRect(x: x, y: y, width: width, height: CGFloat(height))
        //2、遍历属性,并修改
        for index in 0..<self.allAttributesArray.count {
            let attrs = self.allAttributesArray[index]
            //2.1、判断是否和visiableRect交叉
            if !visiableRect.intersects(attrs.frame) {
                continue
            }
            //2.2、计算frame
            var tempX = attrs.frame.origin.x
            let tempY = 0
            var tempWidth = self.itemSize.width
            let tempHeight = self.itemSize.height
            //重新计算X(第一个不用计算,后续的以前一个为准)
            if index > 0 {
                let preAttrs = self.allAttributesArray[index - 1]
                tempX = preAttrs.frame.maxX
            }
            //重新计算tempWidth
            let size = self.delegate?.getItemSize(indexPath: attrs.indexPath)
            tempWidth = size?.width ?? 0
            //attrs重新赋值
            attrs.frame = CGRect(x: Int(tempX), y: tempY, width: Int(tempWidth), height: Int(tempHeight))
            self.maxX = Int(attrs.frame.maxX)
            //添加到数组
            resultArray.append(attrs)
        }
        return resultArray
    }
    
    //MARK:4
    //MARK:这个看情况定,这里横向滚动并且改变cell宽度,肯定会影响ContentSize
    //所以要重新计算
    override var collectionViewContentSize: CGSize{
        return CGSize(width: self.maxX, height: 0)
    }
}
