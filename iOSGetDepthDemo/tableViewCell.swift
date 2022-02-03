//
//  File.swift
//  swiftTableController
//
//  Created by 张增辉 on 2021/3/27.
//

import Foundation
import UIKit

class tableViewCell:UITableViewCell{
    var lableTitle:UILabel?
    var lableContent:UILabel?
    var dataCell:CellData?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configCell(data:CellData){
        
        dataCell = data
        setUI()
    }
    
    func setUI(){
        lableTitle = UILabel.init(frame: CGRect(x: 16, y: 0, width: frame.width, height: 30))
        addSubview(lableTitle!)
        //主标题
//        lableTitle?.mas_makeConstraints({ make in
//            make?.top.equalTo()(self.mas_top)?.offset()(3)
//            make?.left.equalTo()(self.mas_left)?.offset()(16)
//            make?.height.equalTo()(self.mas_height)?.offset()(-50)
//            make?.width.equalTo()(mas_width)
//        })
        lableTitle?.font = UIFont.boldSystemFont(ofSize: 18)
        lableTitle?.textAlignment = .left
        lableTitle?.textColor = #colorLiteral(red: 0.3070672154, green: 0.6932175159, blue: 0.7965009809, alpha: 1)
        lableTitle?.text = dataCell!.title
        
        //副标题
        lableContent = UILabel.init(frame: CGRect(x: 16, y: 30, width: UIScreen.main.bounds.size.width, height: 38))
        self.addSubview(lableContent!)
//        lableContent?.mas_makeConstraints({ make in
//            make?.top.equalTo()(lableTitle?.mas_bottom)?.offset()(0)
//            make?.left.equalTo()(lableTitle)
//            make?.width.equalTo()(lableTitle)
//            make?.height.equalTo()(36)
//        })
        lableContent?.text = dataCell?.content
        lableContent?.font = UIFont.systemFont(ofSize: 13)
        lableContent?.textAlignment = .left
        lableContent?.textColor = #colorLiteral(red: 0.471976459, green: 0.7609836459, blue: 0.7003547549, alpha: 1)
    }
}
