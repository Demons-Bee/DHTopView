//
//  DHTopView.swift
//  DHTopView
//
//  Created by 胡大函 on 14/11/13.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

import UIKit
import Accelerate

class DHTopView: UIView {

  var scrollView: UIScrollView!
  var scrollContentView: UIView!
  var headerImageView: UIImageView!
  var tableView: UITableView!
  var hiddingSpace: CGFloat!
  var topViewHeight: CGFloat!
  
  convenience init(frame: CGRect, tableViewHeaderHeight: CGFloat, topViewHeight: CGFloat, topViewImage: UIImage) {
    self.init(frame: frame)
    headerImageView = UIImageView(frame: CGRect(origin: CGPointZero, size: CGSize(width: frame.size.width, height: topViewHeight)))
    headerImageView.image = topViewImage
    self.addSubview(headerImageView)
    
    tableView = UITableView(frame: self.frame, style: UITableViewStyle.Plain)
    tableView.tableHeaderView = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: frame.size.width, height: tableViewHeaderHeight)))
    tableView.tableHeaderView!.backgroundColor = UIColor.clearColor()
    tableView.backgroundColor = UIColor.clearColor()
    self.addSubview(tableView)
    
    tableView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
    self.topViewHeight = topViewHeight
    hiddingSpace = topViewHeight - tableViewHeaderHeight
  }
  
  convenience init(frame: CGRect, scrollViewHeaderHeight: CGFloat, scrollViewContentHeight: CGFloat, topViewHeight: CGFloat, topViewImage: UIImage) {
    self.init(frame: frame)
    headerImageView = UIImageView(frame: CGRect(origin: CGPointZero, size: CGSize(width: frame.size.width, height: topViewHeight)))
    headerImageView.image = topViewImage
    self.addSubview(headerImageView)
    
    scrollView = UIScrollView(frame: self.frame)
    scrollView.backgroundColor = UIColor.clearColor()
    self.addSubview(scrollView)
    
    scrollContentView = UIView(frame: CGRect(x: 0, y: scrollViewHeaderHeight, width: frame.size.width, height: scrollViewContentHeight))
    scrollContentView.backgroundColor = UIColor.whiteColor()
    scrollView.contentSize = scrollContentView.frame.size
    scrollView.addSubview(scrollContentView)
    
    scrollView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
    self.topViewHeight = topViewHeight
    hiddingSpace = topViewHeight - scrollViewHeaderHeight
  }
  
}

extension DHTopView {
  
  override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
    if tableView != nil {
      animationForScrollView(scrollView: tableView)
    } else if scrollView != nil {
      animationForScrollView(scrollView: scrollView)
    }
  }
  
  func animationForScrollView(#scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    if offset > -hiddingSpace {
      
      if offset > 0 {
        headerImageView.frame = CGRect(x: 0, y: -offset * 0.5, width: self.frame.size.width, height: topViewHeight)
      }
    } else {
      let center = headerImageView.center
      if offset < -hiddingSpace {
        headerImageView.frame = CGRect(x: offset + hiddingSpace, y: 0, width: self.frame.size.width + (-offset - hiddingSpace) * 2, height: topViewHeight + (-offset - hiddingSpace) * 2)
        headerImageView.center = center
      } else {
        headerImageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: topViewHeight)
      }
    }
  }
  
  override func removeFromSuperview() {
    if tableView != nil {
      tableView .removeObserver(self, forKeyPath: "contentOffset")
    } else {
      scrollView .removeObserver(self, forKeyPath: "contentOffset")
    }
    super.removeFromSuperview()
  }
  
}