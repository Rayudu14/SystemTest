//
//  ViewController.swift
//  SystemTest
//
//  Created by Raidu on 7/3/20.
//  Copyright © 2020 Raidu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cellId        = "cellId"
    var rowsTableView = UITableView()
    var rowsVM        = RowsViewModel()
    
    var navTitle: String = "" {
        didSet {
            updateNavTitle()
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.darkGray
        return refreshControl
    }()
    
    override func loadView() {
        super.loadView()
        
        setupTableView()
        rowsVM.vc = self
        rowsVM.getRowsInfoFromService()
    }
    
    func updateNavTitle() {
        navigationItem.title = navTitle
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        rowsVM.getRowsInfoFromService()
        refreshControl.endRefreshing()
    }
        
    func setupTableView() {
        view.addSubview(rowsTableView)
        rowsTableView.addSubview(self.refreshControl)
        rowsTableView.translatesAutoresizingMaskIntoConstraints = false
        rowsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rowsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rowsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        rowsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        rowsTableView.dataSource = self
        rowsTableView.register(RowDataCell.self, forCellReuseIdentifier: cellId)
    }
}
extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowsVM.rowsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell            = tableView.dequeueReusableCell(withIdentifier: cellId, for:                                       indexPath) as! RowDataCell
        cell.selectionStyle = .none
        let rowModel        = rowsVM.rowsArray[indexPath.row]
        cell.row            = rowModel
        return cell
    }
}
