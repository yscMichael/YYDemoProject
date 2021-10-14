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
    //属性数组
    var attrArray: Array<UICollectionViewLayoutAttributes> = Array<UICollectionViewLayoutAttributes>()
}

extension YYLineFlowOneLayout{
    //MARK:流水布局实现下面三种方法
    //MARK:1
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //MARK:2
    override func prepare() {
        super.prepare()
        print("prepare===========P")
        self.attrArray.removeAll()
        //计算数组
    }
    
    //MARK:3
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("layoutAttributesForElements===========P")
        var resultArray = Array<UICollectionViewLayoutAttributes>()
        //1、获取可见矩形框
        let x = self.collectionView?.contentOffset.x ?? 0
        let y = self.collectionView?.contentOffset.y ?? 0
        let width = self.collectionView?.frame.size.width ?? 0
        let height = self.collectionView?.frame.size.height ?? 0
        let visiableRect = CGRect(x: x, y: y, width: width, height: CGFloat(height))
        //2、获取交叉区域cell的UICollectionViewLayoutAttributes
        let attriArray = super.layoutAttributesForElements(in: rect)
        if attriArray != nil {
            for index in 0..<attriArray!.count {
                let attrs = attriArray![index]
                //判断是否是交叉区域
                if !visiableRect.intersects(attrs.frame) {
                    continue
                }
                print("===========================================\(attrs.indexPath.row)")
                print("visiableRect=\(visiableRect)")
                print("attrs.frame1=\(attrs.frame)")
                print("attrs.indexPath.row=\(attrs.indexPath.row)")
                //3、计算新的Frame
                let tempX = attrs.indexPath.row * YYCellWidth + Int(self.minimumLineSpacing)*(attrs.indexPath.row - 1)
                let tempY = 0
                let tempWidth = YYCellWidth
                let tempHeight = YYCellHeight
                attrs.frame = CGRect(x: tempX, y: tempY, width: Int(tempWidth), height: tempHeight)
                //4、标记最后一个可见cell位置
                print("attrs.frame2=\(attrs.frame)")
                print("rect=\(rect)")
                //5、添加到数组
                resultArray.append(attrs)
            }
            return resultArray
        }else{
            return resultArray
        }
    }
}
