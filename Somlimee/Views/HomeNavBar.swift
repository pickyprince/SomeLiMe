//
//  HomeNavBar.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/17.
//

import UIKit

fileprivate enum NavData{
    static let title: String = "광장게시판"
    static let dropDownList: [String] = ["A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장"]
}

class HomeNavBar: UIView {
    
    
    let titleView = UIStackView()
    let buttonGroups = UIStackView()
    let profileButton = UIButton()
    let searchButton = UIButton()
    let title = UILabel()
    let dropDownButton = UIButton()
    let leftDrawerButton = UIButton()
    let blurEffect = UIBlurEffect(style: .regular)
    let blurEffectView = UIVisualEffectView()
    
    let tableView: DropDownBoardPickerView = DropDownBoardPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(){
        
        //Auto layout pre-setup
        self.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.contentView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        buttonGroups.translatesAutoresizingMaskIntoConstraints = false
        leftDrawerButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Data assignment
        tableView.data = NavData.dropDownList
        
        
        //UI configuration
        titleView.axis = .horizontal
        buttonGroups.distribution = .fill
        buttonGroups.axis = .horizontal
        buttonGroups.spacing = 10
        dropDownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        dropDownButton.tintColor = .label
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        leftDrawerButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        leftDrawerButton.tintColor = .label
        blurEffectView.effect = blurEffect
        title.text = NavData.title
        
        profileButton.setImage(UIImage(named: "sadfrog"), for: .normal)
        profileButton.widthAnchor.constraint(equalToConstant: searchButton.intrinsicContentSize.width + 10).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: searchButton.intrinsicContentSize.height + 10).isActive = true
        profileButton.layer.cornerRadius = .greatestFiniteMagnitude
        
        self.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(titleView)
        blurEffectView.contentView.addSubview(buttonGroups)
        blurEffectView.contentView.addSubview(leftDrawerButton)
        buttonGroups.addArrangedSubview(searchButton)
        buttonGroups.addArrangedSubview(profileButton)
        titleView.addArrangedSubview(title)
        titleView.addArrangedSubview(dropDownButton)
        titleView.distribution = .fill
        titleView.spacing = 5
        
//        tableView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        tableView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        leftDrawerButton.leadingAnchor.constraint(equalTo:blurEffectView.contentView.leadingAnchor, constant: 10).isActive = true
        leftDrawerButton.bottomAnchor.constraint(equalTo:blurEffectView.contentView.bottomAnchor, constant: -10).isActive = true
        buttonGroups.trailingAnchor.constraint(equalTo:blurEffectView.contentView.trailingAnchor, constant: -10).isActive = true
        buttonGroups.bottomAnchor.constraint(equalTo:         blurEffectView.contentView.bottomAnchor, constant: -10).isActive = true
        titleView.centerXAnchor.constraint(equalTo:         blurEffectView.contentView.centerXAnchor).isActive = true
        titleView.bottomAnchor.constraint(equalTo:         blurEffectView.contentView.bottomAnchor, constant: -10).isActive = true
        
        NSLayoutConstraint.activate([
        self.topAnchor.constraint(equalTo:         blurEffectView.topAnchor),
        self.bottomAnchor.constraint(equalTo:         blurEffectView.bottomAnchor),
        self.leadingAnchor.constraint(equalTo:         blurEffectView.leadingAnchor),
        self.trailingAnchor.constraint(equalTo:         blurEffectView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo:         blurEffectView.contentView.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo:         blurEffectView.contentView.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo:         blurEffectView.contentView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo:         blurEffectView.contentView.trailingAnchor)
        ])
        
    }
    
}
