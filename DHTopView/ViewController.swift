//
//  ViewController.swift
//  DHTopView
//
//  Created by 胡大函 on 14/11/13.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var viewStyle1: DHTopView!
  var viewStyle2: DHTopView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewStyle1 = DHTopView(frame: self.view.frame, tableViewHeaderHeight: 150, topViewHeight: 200, topViewImage: UIImage(named: "image.jpg")!)
    viewStyle1.tableView.delegate = self
    viewStyle1.tableView.dataSource = self
    viewStyle1.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    self.view.addSubview(viewStyle1)
    // Do any additional setup after loading the view, typically from a nib.
    
    viewStyle2 = DHTopView(frame: self.view.frame, scrollViewHeaderHeight: 150, scrollViewContentHeight: 1000, topViewHeight: 200, topViewImage: UIImage(named: "image2.jpg")!)
    self.view.addSubview(viewStyle2)
    
  }
  
  @IBAction func changeView(sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      self.view.sendSubviewToBack(viewStyle1)
    } else {
      self.view.sendSubviewToBack(viewStyle2)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

//  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    if section != 0 {
//      return 10
//    }
//    return 0
//  }
//  
//  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//    if section == 2 {
//      return 10
//    }
//    return 0
//  }
//  
//  func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//    if section == 2 {
//      return UIView()
//    }
//    return UIView()
//  }
//  
//  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//    return 3
//  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    cell.textLabel.text = "Cell----\(indexPath.row + 1)"
    return cell
  }
  
}

