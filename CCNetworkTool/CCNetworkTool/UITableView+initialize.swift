//
//  UITableView+initialize.swift
//  echeNew
//
//  Created by tree on 2018/12/21.
//  Copyright © 2018 tree. All rights reserved.
//

import Foundation
import UIKit

@objc
public extension UITableView {
    
    class func tableView() -> UITableView {
        let tableView: UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.setInitProperty()
        tableView.tableFooterView = UIView.init()
        return tableView
    }
    
    class func groupTableView() -> UITableView {
        let tableView: UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.setInitProperty()
        return tableView
    }
    
     func setInitProperty() {
        self.indicatorStyle = .white
        self.isScrollEnabled = true
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.clear
        self.backgroundView = nil
//        self.tableFooterView = UIView.init()
        
//        self.sectionHeaderHeight = 0.0
//        self.sectionFooterHeight = 0.0
        
//        self.separatorStyle = .singleLine
        
//        if #available(iOS 11.0, *) {
//            self.contentInsetAdjustmentBehavior = .never
//            self.insetsContentViewsToSafeArea = false
//        }
    }
}
