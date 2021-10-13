//
//  YYMainViewController.swift
//  YYTableViewLeftDeleteProject
//
//  Created by 杨世川 on 2021/9/24.
//

import UIKit

let SPCScreenWidth = UIScreen.main.bounds.size.width
let SPCScreenHeight = UIScreen.main.bounds.size.height

class YYMainViewController: UIViewController {
    //MARK: - 属性 -
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.layoutViews()
        self.initData()
    }
    
    //MARK:初始化Views
    func initViews() -> () {
        self.view.addSubview(self.tableView)
    }
    
    //布局子View
    func layoutViews() -> () {
        
    }
    
    //初始化数据
    func initData() -> () {
        
    }
    
    //MARK: - Event Response -
    
    //MARK: - Public  Methods -
    
    //MARK: - Private Methods -
    
    //MARk: - lazy Property -
    
    //MARK: - lazy  Methods -
    //MARK:tableView
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SPCScreenWidth, height: SPCScreenHeight), style: UITableView.Style.plain)
        //设置颜色和滚动条
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        //代理设置
        tableView.delegate = self
        tableView.dataSource = self
        //无分割线
        tableView.separatorStyle = .none
        //注册cell
        tableView.register(UINib.init(nibName: "SPCHomeListTableViewCell", bundle: nil), forCellReuseIdentifier: "SPCHomeListTableViewCell");
        return tableView
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
//MARK:UITableViewDataSource
extension YYMainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell: SPCHomeListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SPCHomeListTableViewCell", for: indexPath) as! SPCHomeListTableViewCell
        return listCell
    }
}

//MARK:UITableViewDelegate
extension YYMainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180;
    }
}
