//
//  ViewController.swift
//  swiftTableController
//
//  Created by 张增辉 on 2021/2/2.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView = {
        var tmp = UITableView.init(frame: CGRect.init(x: 0, y: 0, width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        return tmp
    }()
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initOther()
        view.addSubview(tableView)
    }
    func initOther(){
        self.title = "TODO"
    }
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(tableViewCell.self, forCellReuseIdentifier: "cell")
    }
    //MARK: TABLEVIEW dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shareData.shareInstance[section].sources.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return shareData.shareInstance[section].sectionTitle
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return shareData.shareInstance.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! tableViewCell
        let cellData = shareData.shareInstance[indexPath.section].sources[indexPath.row]
        cell.configCell(data: cellData)
        return cell
    }
    
    //MARK:DELEGATE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = shareData.shareInstance[indexPath.section].sources[indexPath.row]
        guard let vc = cellData.getVc() else {
            return
        }
        vc.title = cellData.title
        NSLog("begin")
        
        self.present(vc, animated: true, completion: nil)
        NSLog("stop")
    }


}

