//
//  YYLineFlowTwoLayout.swift
//  YYCollectionViewScroll
//
//  Created by 杨世川 on 2021/10/14.
//

import UIKit

class YYLineFlowTwoLayout: UICollectionViewLayout {
    //最大X
    var maxX = 0
    //cell的所有属性数组
    var allAttributesArray: Array<UICollectionViewLayoutAttributes> = Array<UICollectionViewLayoutAttributes>()
    //代理
    weak var delegate: SPCCustomFlowLayoutDelegate?
}

extension YYLineFlowTwoLayout{
    //MARK:1
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    //MARK:2
    override func prepare() {
        super.prepare()
        print("prepare=======P")
        //2.1、数值清空
        self.maxX = 0
        self.allAttributesArray.removeAll()
        //2.2、获取所有属性
        let count = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        for index in 0..<count {
            let attrs = self.collectionView?.layoutAttributesForItem(at: IndexPath(item: index, section: 0))
            if attrs != nil {
                self.allAttributesArray.append(attrs!)
            }
        }
    }

    //MARK:3
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print("layoutAttributesForItem=======P")
        //获取文本大小
        let size = self.delegate?.getItemSize(indexPath: indexPath)
        let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        //计算Frame
        let tempX = self.maxX
        let tempY = 0
        let tempWidth = size?.width ?? 0
        let tempHeight = YYCellHeight
        //attrs重新赋值
        attrs.frame = CGRect(x: Int(tempX), y: tempY, width: Int(tempWidth), height: Int(tempHeight))
        //最大值重新赋值
        self.maxX = Int(attrs.frame.maxX)
        return attrs
    }

    //MARK:4
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("layoutAttributesForElements=======P")
        return self.allAttributesArray
    }

    //MARK:5
    override var collectionViewContentSize: CGSize{
        print("collectionViewContentSize=\(self.maxX)")
        return CGSize(width: self.maxX, height: 0)
    }
    
}
