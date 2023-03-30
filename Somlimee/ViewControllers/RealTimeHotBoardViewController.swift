//
//  RealTimeHotBoardViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/23.
//

import UIKit

class RealTimeHotBoardViewController: UIViewController {
    let label: UILabel = {
        let label = UILabel()
        label.text = "real time hot detail view"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = .systemGray4
    }

}
