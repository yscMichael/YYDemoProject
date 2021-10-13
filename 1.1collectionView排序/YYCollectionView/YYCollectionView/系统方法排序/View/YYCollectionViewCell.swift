//
//  YYCollectionViewCell.swift
//  YYCollectionView
//
//  Created by 杨世川 on 2021/10/8.
//

import UIKit

class YYCollectionViewCell: UICollectionViewCell {
    //MARK:- 属性 -
    //MARK:内容Label
    @IBOutlet weak var label: UILabel!
    
    //MARK:- Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
    }
}
