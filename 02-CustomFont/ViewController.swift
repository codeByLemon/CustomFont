//
//  ViewController.swift
//  02-CustomFont
//
//  Created by 张延 on 2017/8/25.
//  Copyright © 2017年 com.CocoaLemon.www. All rights reserved.
//
// 注意：只要在绘制cell的方法中，写上这句代码，就会有如下警告：'UITableViewCell' to nil always returns false
/*
 if cell == nil {
 
    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "systemCell")
 }
 */

import UIKit

class ViewController: UIViewController {

    var tableView : UITableView?
    var changeBtn : UIButton?
    var isRefresh = false
    var count = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 布局NavigationBar
        setUpBar()
        // 创建View
        creatTableView()
    
    }
    // MARK:按钮点击事件
    func changeFontAction(btn:UIButton) {
        
        count = count + 1
        print(count)

        if count <= 3 {
            isRefresh = true
            tableView?.reloadData()
            
        }else{
            isRefresh = false

        }
    }
    // MARK:创建TableView
    func creatTableView() {
        
        tableView = UITableView.init(frame: UIScreen.main.bounds)
        tableView?.backgroundColor = UIColor.black
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        // 注册cell
//        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "systemCell")
        tableView?.register(        UITableViewCell.classForCoder(), forCellReuseIdentifier: "systemCell")

        view.addSubview(tableView!)
        
        changeBtn = UIButton.init(type: UIButtonType.custom)
        changeBtn?.frame = CGRect.init(x:  view.frame.width / 3, y: view.frame.height - 180, width: 150, height: 150)
        changeBtn?.backgroundColor = UIColor.orange
        changeBtn?.setTitle("change Font", for: UIControlState.normal)
        changeBtn?.setTitleColor(UIColor.white, for: UIControlState.normal)
        changeBtn?.titleLabel?.font = UIFont.init(name: "AppleGothic", size: 18)
        changeBtn?.layer.cornerRadius = 75
        changeBtn?.layer.masksToBounds = true
        changeBtn?.addTarget(self, action: #selector(changeFontAction), for: UIControlEvents.touchUpInside)
        view.addSubview(changeBtn!)
    }
    // MARK:懒加载
    lazy var dataArray = {
        
        return ["2017年8月25日","我的第二个Swift练习项目","我坚持跑步三周了","我眼镜坏了","我正在学习化妆","我正在准备面试"]
    }()
    // MARK:设置导航栏
    func setUpBar(){
        
        title = "CustomFont"
        // 导航栏颜色
        navigationController?.navigationBar.barTintColor = UIColor.black
        // 导航栏title颜色
        let dic : NSDictionary = [NSForegroundColorAttributeName : UIColor.white,NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18)]
        navigationController?.navigationBar.titleTextAttributes = dic as? [String : Any]
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "systemCell", for: indexPath)
        // 在我没有设置这句话的时候，tableView的cell都是白色的
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = dataArray[indexPath.row]
        if isRefresh == true {
            switch count {
            case 0:
                cell.textLabel?.font = UIFont.init(name: "Arial-BoldMT", size: 18)
            case 1:
                cell.textLabel?.font = UIFont.init(name: "Courier-BoldOblique", size: 18)
            case 2:
                cell.textLabel?.font = UIFont.init(name: "HelveticaNeuer", size: 18)
            default:
                count = 0
                cell.textLabel?.font = UIFont.init(name: "AppleGothic", size: 18)
            }
        }
        return cell
    }
}
