//
//  SideMenuView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/23.
//

import UIKit

class SideMenuViewController: UIViewController {
    let data: [String] = ["menu label item","menu label item","menu label item","menu label item",]
    let tableView: NormalTableView = NormalTableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.data = self.data
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        
    }

}
