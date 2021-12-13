//
//  YYPlayerView.swift
//  YYTableViewPlayerCell
//
//  Created by 杨世川 on 2021/12/13.
//

import UIKit

class YYPlayerView: UIView {
    var testTimer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        //开启一个定时器用看看缓存
        self.testTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeCount), userInfo: nil, repeats: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func timeCount() -> () {
        print("定时器================={{{")
    }
    
    //MARK:设备名称
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.init(frame: CGRect.zero)
        nameLabel.text = "测试复用-------"
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        nameLabel.backgroundColor = UIColor.blue
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
}
