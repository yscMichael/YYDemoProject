//
//  YYCollectionReusableView.swift
//  YYCollectionView
//
//  Created by 杨世川 on 2021/12/21.
//

import UIKit

class YYCollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
