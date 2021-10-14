//
//  YYLineFlowOneLayout.swift
//  YYCollectionViewScroll
//
//  Created by 杨世川 on 2021/10/13.
//

import UIKit

//MARK:- 常量 -

protocol SPCCustomFlowLayoutDelegate: NSObjectProtocol {
    //获取每一项的大小
    func getItemSize(indexPath: IndexPath) -> (CGSize)
}

class YYLineFlowOneLayout: UICollectionViewFlowLayout {
    //数组
    var allAttributesArray: Array<UICollectionViewLayoutAttributes> = Array<UICollectionViewLayoutAttributes>()
    
    //代理
    weak var delegate: SPCCustomFlowLayoutDelegate?
}

extension YYLineFlowOneLayout{
    //MARK:流水布局实现下面三种方法
    //MARK: 设置为true,collectionView一旦滑动就会调用prepare和layoutAttributesForElements
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //MARK: 一些初始化工作最好在这里实现(此时collectionView的frame已完成)
    override func prepare() {
        super.prepare()
//        print("prepare===========P")
        self.allAttributesArray.removeAll()
        //获取所有属性(因为系统获取的永远是没有改变的)
    }
    
    override var collectionViewContentSize: CGSize{
        //这里要计算
        return CGSize(width: 100000, height: YYCellHeight)
    }
    
    //MARK:设置cell的位置等相关(根据indexPath.row计算)
    //MARK:这里系统的属性是没有发生变化的(系统也要求深拷贝)
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        print("layoutAttributesForElements===========P")
        //最终返回的数组
        var resultArray = Array<UICollectionViewLayoutAttributes>()
        //1、获取当前屏幕可见区域
        let x = self.collectionView?.contentOffset.x ?? 0
        let y = self.collectionView?.contentOffset.y ?? 0
        let width = self.collectionView?.frame.size.width ?? 0
        let height = self.collectionView?.frame.size.height ?? 0
        let visiableRect = CGRect(x: x, y: y, width: width, height: CGFloat(height))
        //2、获取《交叉》区域cell的UICollectionViewLayoutAttributes
        var tempArray = Array<UICollectionViewLayoutAttributes>()
        let attriArray = super.layoutAttributesForElements(in: rect)
//        for index in attriArray! {
//            print("观察是否改变了Frame---\(index.indexPath.row)")
//            print(index.frame)
//        }
        
        for attrs in attriArray! {
            let tempAttrs = attrs.copy()
            tempArray.append(tempAttrs as! UICollectionViewLayoutAttributes)
            
        }
        //遍历添加属性
//        if tempArray != nil {
        print("开始遍历==================+P")
            for index in 0..<tempArray.count {
                let attrs = tempArray[index]
                //判断是否是交叉区域(用contains的话,边界会有问题)
                //这里会发生调变是因为系统的attrs.frame没有发生改变
                //但是实际效果发生改变了frame改变了(所以这里判断失误了,发生了调变)
                if !visiableRect.intersects(attrs.frame) {
//                    print("不在区域内==================\(attrs.indexPath.row)")
                    print("index=\(index)不在区域内")
                    continue
                }

//                print("visiableRect=\(visiableRect)")
//                print("attrs.frame1=\(attrs.frame)")
//                print("attrs.indexPath.row=\(attrs.indexPath.row)")
                //3、计算新的Frame
                //固定X
                //let tempX = attrs.indexPath.row * Int(self.itemSize.width) + Int(self.minimumLineSpacing)*(attrs.indexPath.row - 1)
                //动态X
                var tempX = attrs.frame.origin.x
                //获取文本宽度
                let size = self.delegate?.getItemSize(indexPath: attrs.indexPath)
                if index > 0 {//获取前一个cell的最大X
                    let preAttrs = tempArray[index - 1]
                    tempX = preAttrs.frame.maxX
                }
                let tempY = 0
                let tempWidth = size?.width ?? 0
                let tempHeight = self.itemSize.height
                if (attrs.indexPath.row == 0) || (attrs.indexPath.row == 1) {
//                    print("===========================================\(attrs.indexPath.row)")
                    if index > 0 {
                        let preAttrs = tempArray[index - 1]
//                        print("preAttrs.frame=\(preAttrs.frame)")
                    }
//                    print("attrs.frame变化前=\(attrs.frame)")
                }
                attrs.frame = CGRect(x: Int(tempX), y: tempY, width: Int(tempWidth), height: Int(tempHeight))
                if (attrs.indexPath.row == 0) || (attrs.indexPath.row == 1) {
//                    print("attrs.frame变化后=\(attrs.frame)")
                }
                if index == 0 {
                    print("collectionView偏移=\(self.collectionView?.contentOffset.x)")
                    print("attrs.indexPath.row=\(attrs.indexPath.row)")
                    print("frame=\(attrs.frame)")
                }
                //4、添加到数组
                resultArray.append(attrs)
            }
            return resultArray
//        }else{
//            return resultArray
//        }
    }
}
