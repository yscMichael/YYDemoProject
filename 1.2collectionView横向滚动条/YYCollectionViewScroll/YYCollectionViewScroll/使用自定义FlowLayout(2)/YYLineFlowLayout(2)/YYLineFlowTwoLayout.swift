//
//  YYLineFlowTwoLayout.swift
//  YYCollectionViewScroll
//
//  Created by 杨世川 on 2021/10/14.
//

import UIKit

class YYLineFlowTwoLayout: UICollectionViewFlowLayout {
    //最大X
    var maxX = 0
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
        
    }

    //MARK:3
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }

    //MARK:4
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var array = Array<UICollectionViewLayoutAttributes>()
        let totalCount = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        for index in 0..<totalCount {
            let attrs = self.layoutAttributesForItem(at: IndexPath.init(item: index, section: 0))
            if attrs != nil {
                array.append(attrs!)
            }
        }
        return array
    }

    //MARK:5
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: 0)
    }
    
}
