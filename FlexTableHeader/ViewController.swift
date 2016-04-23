//
//  ViewController.swift
//  FlexTableHeader
//
//  Created by Wenbin Zhang on 4/22/16.
//  Copyright © 2016 Wenbin Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var data: [String] = [String]()
    var tableView: UITableView!
    let cellIdentifier = "cellIdentifier"
    var previousOffset = 0.0
    var headerView: TableHeaderView!
    let shouldUpdateHeader = true
    var headerViewInitialHeight: CGFloat = 0.0

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<100 {
            data.append("Test\(i)")
        }
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: nil, action: nil)
        navigationController?.setNavBarTransparent()
        tableView = UITableView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: CGRectGetWidth(view.bounds), height: CGRectGetHeight(view.bounds))), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        headerView = TableHeaderView(frame: CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 200))
        view.addSubview(headerView)
        headerViewInitialHeight = headerView.frame.height
        tableView.contentInset = UIEdgeInsetsMake(200, tableView.contentInset.left, tableView.contentInset.bottom, tableView.contentInset.right)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        previousOffset = Double(tableView.contentOffset.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: TableView datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        cell?.textLabel?.text = data[indexPath.row]
        return cell!
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 44))
        sectionView.backgroundColor = UIColor.blueColor()
        return sectionView
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let offset = Double(scrollView.contentOffset.y) - previousOffset
//        let distanceToTravel = (200 - 64) / 2.0
//        let alphaScale = offset/(distanceToTravel/2)
//        headerView.fadeContent(1-alphaScale)
        let height = -scrollView.contentOffset.y > 64.0 ? -scrollView.contentOffset.y : 64.0
        if headerView.frame.height == CGFloat(height) {
            return
        }
        headerView.frame = CGRectMake(0, headerView.frame.origin.y, CGRectGetWidth(headerView.frame), height)
        let insetTop = headerView.frame.height > headerViewInitialHeight ? headerViewInitialHeight : headerView.frame.height
        scrollView.contentInset = UIEdgeInsets(top: insetTop, left: 0, bottom: 0, right: 0)
    }
}

extension UINavigationController {
    func setNavBarTransparent() {
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        navigationBar.translucent = true
        navigationBar.backgroundColor = UIColor.clearColor()
    }

    func removeTransparent() {
        navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        navigationBar.translucent = false
        navigationBar.backgroundColor = UIColor.cyanColor()
    }
}
