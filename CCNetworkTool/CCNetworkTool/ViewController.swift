//
//  ViewController.swift
//  CCNetworkTool
//
//  Created by chenyi on 2020/5/19.
//  Copyright © 2020 chenyi. All rights reserved.
//

import UIKit

import SwiftyJSON
import HandyJSON
import Moya
import SnapKit
struct HomeRootModel : HandyJSON {
    
    var title:  String?
    var ga_prefix: String?
    var images: String?
    var multipic: String?
    var hint: String?
    var type: Int?
    var id: Int?
    
}
class ViewController: UIViewController {

    var cancelableRequest: Cancellable?
    var modelArr  = [HomeRootModel?]()
    private var tableView: UITableView = UITableView.tableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
        self.getPreData()
        // Do any additional setup after loading the view.
    }

    private func setupSubviews() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag;
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top).offset(0)
            $0.bottom.equalTo(self.view.snp.bottomMargin)
            $0.left.right.equalToSuperview()
        }
        self.getPreData()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 取消网络请求。
        cancelableRequest?.cancel()
    }
    func getPreData() {
        testZhiHuDailyAPI()
//        testAPI()
        }
    func testZhiHuDailyAPI() {
        cancelableRequest = NetWorkRequest(.easyRequset, completion: { (responseString) -> (Void) in
                                   
            guard let modelTmp = JSONDeserializer<HomeRootModel>.deserializeModelArrayFrom(json: responseString.description,designatedPath: "stories")
                else {
                    return
                    
            }
            self.modelArr = modelTmp
            self.tableView.reloadData()
        
        }, failed: { (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
        }, errorResult: { () -> (Void) in
            print("网络异常")
        })

    }
    
    func testAPI() {
        var paraDict: [String:Any] = Dictionary()
        paraDict["app_type_"] = "1"
        NetWorkRequest(.updateAPi(parameters: paraDict)) { (responseString) -> (Void) in
            
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:.value1, reuseIdentifier: "cell2")
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        if self.modelArr.count > indexPath.row {
            let model : HomeRootModel = self.modelArr[indexPath.row] ?? HomeRootModel()
            cell.textLabel?.text = model.title;

            cell.detailTextLabel?.text = model.hint
        }
        return cell
        
    }
    
}
