//
//  BoardNavBar.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/22.
//

import UIKit

class BoardNavBar: UIView {
    
    
    let titleView = UIStackView()
    let buttonGroups = UIStackView()
    let searchButton = UIButton()
    let title = UILabel()
    let dropDownButton = UIButton()
    let backButton = UIButton()
    let blurEffect = UIBlurEffect(style: .regular)
    let container = UIVisualEffectView()
    let screenSize: CGRect = UIScreen.main.bounds
    var viewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var viewWidthConsstraint: NSLayoutConstraint = NSLayoutConstraint()
    var dropDownTableHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var defaultMultiplierOfHeight: CGFloat = 0.12
    var multiplierOfDropDownTable: CGFloat = 0.18
    let dropDownTableContainer = UIVisualEffectView()
    let dropDownTable: NormalTableView = NormalTableView()
    var onTouchUpBackButton: (()->Void)?
    private var isDropDown: Bool = false
    @objc private func onTouchUpBack(){
        onTouchUpBackButton?()
    }
    @objc private func dropDownButtonTouchUp(){
        if isDropDown{
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn ,animations: {
                self.dropDownButton.transform = CGAffineTransform(rotationAngle: 0)
                self.dropDownTableHeightConstraint.constant -= self.screenSize.height * self.multiplierOfDropDownTable
                self.layoutIfNeeded()
            }, completion: { isComp in
                if isComp {
                    self.viewHeightConstraint.isActive = false
                    self.viewHeightConstraint = self.heightAnchor.constraint(equalToConstant: self.screenSize.height * self.defaultMultiplierOfHeight)
                    self.viewHeightConstraint.isActive = true
                }
            })
            isDropDown = false
        }else{
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn ,animations: {
                self.dropDownButton.transform = CGAffineTransform(rotationAngle: .pi)
                self.dropDownTableHeightConstraint.constant += self.screenSize.height * self.multiplierOfDropDownTable
                self.layoutIfNeeded()
            }, completion: { isComp in
                if isComp {
                    self.viewHeightConstraint.isActive = false
                    
                    self.viewHeightConstraint = self.heightAnchor.constraint(equalToConstant: self.screenSize.height * (self.defaultMultiplierOfHeight+self.multiplierOfDropDownTable))
                    
                    self.viewHeightConstraint.isActive = true
                }
            })
            
            isDropDown = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(){
        
        
        
        
        //Auto layout pre-setup
        
        //        self.backgroundColor = .blue
        self.translatesAutoresizingMaskIntoConstraints = false
        container.contentView.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        buttonGroups.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        dropDownTableContainer.contentView.translatesAutoresizingMaskIntoConstraints = false
        dropDownTableContainer.translatesAutoresizingMaskIntoConstraints = false
        dropDownTable.translatesAutoresizingMaskIntoConstraints = false
        
        //Data assignment
        dropDownTable.data = NavData.dropDownList
        viewHeightConstraint = self.heightAnchor.constraint(equalToConstant: screenSize.height * defaultMultiplierOfHeight)
        viewWidthConsstraint = self.widthAnchor.constraint(equalToConstant: screenSize.width)
        //UI configuration
        titleView.axis = .horizontal
        buttonGroups.distribution = .fill
        buttonGroups.axis = .horizontal
        buttonGroups.spacing = 10
        dropDownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        dropDownButton.tintColor = .label
        dropDownButton.addTarget(self, action: #selector(dropDownButtonTouchUp), for: .touchUpInside)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        
        //        if let dele = delegate {
        //            searchButton.addTarget(self, action: #selector(dele.SearchButtonTouchUp), for: .touchUpInside)
        //        }
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .label
        backButton.addTarget(self, action: #selector(onTouchUpBack), for: .touchUpInside)
        container.effect = blurEffect
        dropDownTableContainer.effect = blurEffect
        title.text = NavData.title
        
        
        self.addSubview(container)
        self.addSubview(dropDownTableContainer)
        container.contentView.addSubview(titleView)
        container.contentView.addSubview(buttonGroups)
        container.contentView.addSubview(backButton)
        dropDownTableContainer.contentView.addSubview(dropDownTable)
        buttonGroups.addArrangedSubview(searchButton)
        titleView.addArrangedSubview(title)
        titleView.addArrangedSubview(dropDownButton)
        titleView.distribution = .fill
        titleView.spacing = 5
        
        
        backButton.leadingAnchor.constraint(equalTo: container.contentView.leadingAnchor, constant: 10).isActive = true
        backButton.bottomAnchor.constraint(equalTo: container.contentView.bottomAnchor, constant: -10).isActive = true
        buttonGroups.trailingAnchor.constraint(equalTo: container.contentView.trailingAnchor, constant: -10).isActive = true
        buttonGroups.bottomAnchor.constraint(equalTo: container.contentView.bottomAnchor, constant: -10).isActive = true
        titleView.centerXAnchor.constraint(equalTo: container.contentView.centerXAnchor).isActive = true
        titleView.bottomAnchor.constraint(equalTo: container.contentView.bottomAnchor, constant: -10).isActive = true
        
        NSLayoutConstraint.activate([
            viewWidthConsstraint,
            viewHeightConstraint,
            self.topAnchor.constraint(equalTo: container.topAnchor),
            container.heightAnchor.constraint(equalToConstant: screenSize.height * defaultMultiplierOfHeight),
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: container.contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: container.contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: container.contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: container.contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dropDownTableContainer.topAnchor.constraint(equalTo: dropDownTableContainer.contentView.topAnchor),
            dropDownTableContainer.contentView.bottomAnchor.constraint(equalTo:         dropDownTableContainer.bottomAnchor),
            dropDownTableContainer.leadingAnchor.constraint(equalTo:         dropDownTableContainer.contentView.leadingAnchor),
            dropDownTableContainer.trailingAnchor.constraint(equalTo:         dropDownTableContainer.contentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            dropDownTable.topAnchor.constraint(equalTo: dropDownTableContainer.contentView.topAnchor),
            dropDownTable.bottomAnchor.constraint(equalTo: dropDownTableContainer.contentView.bottomAnchor),
            dropDownTable.leadingAnchor.constraint(equalTo: dropDownTableContainer.contentView.leadingAnchor),
            dropDownTable.trailingAnchor.constraint(equalTo: dropDownTableContainer.contentView.trailingAnchor)
        ])
        dropDownTableHeightConstraint = dropDownTableContainer.heightAnchor.constraint(equalToConstant:0)
        NSLayoutConstraint.activate([
            dropDownTableContainer.topAnchor.constraint(equalTo: container.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: dropDownTableContainer.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: dropDownTableContainer.trailingAnchor),
            dropDownTableHeightConstraint
        ])
    }
}
