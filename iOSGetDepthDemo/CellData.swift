//
//  CellData.swift
//  swiftTableController
//
//  Created by 张增辉 on 2021/5/29.
//

import Foundation
import UIKit
// tableCell 数据源
struct CellData {
    var title:String
    var content:String
    var className:String
    func getVc()->UIViewController?{

        let clas: AnyClass? = CellData.GetClassFromString(self.className)
        guard let type = clas as? UIViewController.Type else{
            return nil
        }
        
        return type.init()
    }
    static public func GetClassFromString(_ classString: String) -> AnyClass? {
        
        guard let bundleName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else {
            return nil
        }
        print("bundle:\(bundleName)")
        let totalString = bundleName + "." + classString
        print("totalString:\(totalString)")
        var anyClass: AnyClass? = NSClassFromString(totalString)
        if (anyClass == nil) {
            anyClass = NSClassFromString(classString)
        }
        return anyClass
    }
}

struct CellDataSources {
    var sources:[CellData]
    var sectionTitle:String
}

struct shareData {
    //每个元素表示一个section里面的列表
    static let shareInstance:[CellDataSources] = [CellDataSources(sources: [CellData.init(title: "ARKit-Depth", content: "get depth image by ARKit", className: "ARKitDepthViewController")], sectionTitle: "arkit_scenekit")]
}

