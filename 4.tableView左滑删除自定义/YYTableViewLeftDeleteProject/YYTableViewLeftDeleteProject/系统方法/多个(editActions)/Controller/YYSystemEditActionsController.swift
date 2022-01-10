//
//  YYSystemEditActionsController.swift
//  YYTableViewLeftDeleteProject
//
//  Created by 杨世川 on 2021/12/27.
//

import UIKit

class YYSystemEditActionsController: UIViewController {
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
        self.view.backgroundColor = UIColor.white
        self.title = "editActions按钮"
        self.view.addSubview(self.tableView)
    }
    
    //布局子View
    func layoutViews() -> () {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
        tableView.register(UINib.init(nibName: "YYSystemEditingStyleCell", bundle: nil), forCellReuseIdentifier: "YYSystemEditingStyleCell");
        return tableView
    }()
}

//MARK: - CustomDelegate -

//MARK: - SystemDelegate -
//MARK:UITableViewDataSource
extension YYSystemEditActionsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell: YYSystemEditingStyleCell = tableView.dequeueReusableCell(withIdentifier: "YYSystemEditingStyleCell", for: indexPath) as! YYSystemEditingStyleCell
        return listCell
    }
}

//MARK:UITableViewDelegate
extension YYSystemEditActionsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180;
    }
}
