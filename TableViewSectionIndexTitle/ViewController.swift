//
//  ViewController.swift
//  TableViewSectionIndexTitle
//
//  Created by chunxi on 2018/2/4.
//  Copyright © 2018年 chunxi. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var datas = ["0":[0,1,2,3,4,5,6,7,8,9],
                 "1":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]]
    
    lazy var table1:UITableView = {
        let table = UITableView.init(frame:CGRect(x:0,y:114,width:view.frame.width,height:view.frame.height - 114))
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 100
        return table
    }()
    
    lazy var table2:UITableView = {
        let table = UITableView.init(frame:CGRect(x:0,y:114,width:view.frame.width,height:view.frame.height - 114))
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 100
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let seg = UISegmentedControl(frame: CGRect(x:view.frame.width/2-50,y:74,width:100,height:30))
        seg.insertSegment(withTitle: "table1", at: 0, animated: false)
        seg.insertSegment(withTitle: "table2", at: 1, animated: false)
        seg.addTarget(self , action: #selector(segChanged(_:)), for: .valueChanged)
        seg.selectedSegmentIndex = 0
        view.addSubview(seg)
        
        view.addSubview(table1)
        view.addSubview(table2)
        
        segChanged(seg)
    }

    
    
    @objc func segChanged(_ seg:UISegmentedControl) {
        if seg.selectedSegmentIndex == 0   {
            table1.isHidden = false
            table2.isHidden =  true
        }else{
            table1.isHidden = true
            table2.isHidden =  false
        }
    }
    

    func dataArray(_ tableView:UITableView) -> [Int] {
        if tableView == table1 {
            return datas["0"]!
        }
        return datas["1"]!
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray(tableView).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify = "cellid"
        var cell = tableView.dequeueReusableCell(withIdentifier: identify)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identify)
        }
        var id = ""
        if tableView == table1 {
            id = "-table1"
        }else{
            id = "-table2"
        }
        cell?.textLabel?.text = "\(dataArray(tableView)[indexPath.section])" + id
        return cell!
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return dataArray(tableView).map { (i) -> String in
            return "\(i)"
        }
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if  tableView == table1 {
            print("table1.hidden = \(table1.isHidden)")
        }else if tableView == table2 {
            print("table2.hidden = \(table2.isHidden)")
        }
        return index
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lab = UILabel()
        lab.text =  "  \(dataArray(tableView)[section])"
        lab.backgroundColor = .lightGray
        return lab
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
}

