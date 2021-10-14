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
        print("prepare===========P")
    }
    
    //MARK:设置cell的位置等相关(根据indexPath.row计算)
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("layoutAttributesForElements===========P")
        //最终返回的数组
        var resultArray = Array<UICollectionViewLayoutAttributes>()
        //1、获取当前屏幕可见区域
        let x = self.collectionView?.contentOffset.x ?? 0
        let y = self.collectionView?.contentOffset.y ?? 0
        let width = self.collectionView?.frame.size.width ?? 0
        let height = self.collectionView?.frame.size.height ?? 0
        let visiableRect = CGRect(x: x, y: y, width: width, height: CGFloat(height))
        //2、获取《交叉》区域cell的UICollectionViewLayoutAttributes
        let attriArray = super.layoutAttributesForElements(in: rect)
        if attriArray != nil {
            for index in 0..<attriArray!.count {
                let attrs = attriArray![index]
                //判断是否是交叉区域(用contains的话,边界会有问题)
                if !visiableRect.intersects(attrs.frame) {
                    continue
                }
                print("===========================================\(attrs.indexPath.row)")
                print("visiableRect=\(visiableRect)")
                print("attrs.frame1=\(attrs.frame)")
                print("attrs.indexPath.row=\(attrs.indexPath.row)")
                //3、计算新的Frame
                let tempX = attrs.indexPath.row * Int(self.itemSize.width) + Int(self.minimumLineSpacing)*(attrs.indexPath.row - 1)
                let tempY = 0
                let tempWidth = self.itemSize.width
                let tempHeight = self.itemSize.height
                attrs.frame = CGRect(x: tempX, y: tempY, width: Int(tempWidth), height: Int(tempHeight))
                //4、添加到数组
                resultArray.append(attrs)
            }
            return resultArray
        }else{
            return resultArray
        }
    }
}
