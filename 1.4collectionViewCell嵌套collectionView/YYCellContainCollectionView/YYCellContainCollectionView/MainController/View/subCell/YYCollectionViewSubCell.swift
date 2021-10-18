//
//  YYCollectionViewSubCell.swift
//  YYCellContainCollectionView
//
//  Created by 杨世川 on 2021/10/18.
//

import UIKit

class YYCollectionViewSubCell: UICollectionViewCell {
    //MARK:- 属性 -
    //MARK:图片
    @IBOutlet weak var subImageView: UIImageView!
    
    //MARK:- Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置边界颜色
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.green.cgColor
    }
}
