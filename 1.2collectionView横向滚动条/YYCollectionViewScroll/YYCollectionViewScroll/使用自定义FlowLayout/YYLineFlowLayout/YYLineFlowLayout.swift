//
//  YYLineFlowLayout.swift
//  YYCollectionViewScroll
//
//  Created by 杨世川 on 2021/10/13.
//

import UIKit

//MARK:流水布局实现下面三种方法
class YYLineFlowLayout: UICollectionViewFlowLayout {
    //MARK:1
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //MARK:2
    override func prepare() {
        
    }
    
    //MARK:3
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
    }
}
