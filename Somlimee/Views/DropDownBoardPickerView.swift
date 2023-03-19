//
//  DropDownBoardPickerView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/18.
//

import UIKit

class DropDownBoardPickerView: UITableView {
    public var data: [String] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(DropDownBoardPickerViewCell.self, forCellReuseIdentifier: String(describing: DropDownBoardPickerViewCell.self))
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DropDownBoardPickerView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DropDownBoardPickerViewCell.self), for: indexPath) as! DropDownBoardPickerViewCell
        
        cell.label.text = data[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
}
class DropDownBoardPickerViewCell: UITableViewCell{
    let label = {
        let label = UILabel()
        label.text = "oifejof"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    let view = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(view)
        view.addSubview(label)
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.widthAnchor.constraint(equalTo: self.widthAnchor),
            view.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
