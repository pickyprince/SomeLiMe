//
//  SearchNavBar.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/20.
//

import UIKit


class SearchNavBar: UIView {
    
    weak var delegate: SearchViewController? {
        didSet{
            if let dele = delegate{
                cancelButton.addTarget(dele, action: #selector(dele.cancel), for: .touchUpInside)
            }
        }
    }
    let navViewContainer = UIStackView()
    let searchField = UITextField()
    let searchFieldContainer = UIView()
    let cancelButton = UIButton()
    let cancelButtonContainer = UIView()
    let blurEffect = UIBlurEffect(style: .regular)
    let container = UIVisualEffectView()
    
    let screenSize: CGRect = UIScreen.main.bounds
    var viewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var viewWidthConsstraint: NSLayoutConstraint = NSLayoutConstraint()
    var defaultMultiplierOfHeight: CGFloat = 0.12
    
    

    func setup(){
        
        //Auto layout pre-setup
//        self.backgroundColor = .blue
        self.translatesAutoresizingMaskIntoConstraints = false
        container.contentView.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        navViewContainer.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //Data assignment
        
        
        //UI configuration
        navViewContainer.axis = .horizontal
        
        searchFieldContainer.backgroundColor = .systemGray6
        searchFieldContainer.layer.cornerRadius = 5
        searchField.placeholder = "Type..."
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.label, for: .normal)
        cancelButtonContainer.backgroundColor = .systemGray6
        cancelButtonContainer.layer.cornerRadius = 5
        container.effect = blurEffect
        
        
        self.addSubview(container)
        container.contentView.addSubview(navViewContainer)
        navViewContainer.addArrangedSubview(searchFieldContainer)
        navViewContainer.addArrangedSubview(cancelButtonContainer)
        navViewContainer.distribution = .equalSpacing
        navViewContainer.spacing = 5
        searchFieldContainer.addSubview(searchField)
        cancelButtonContainer.addSubview(cancelButton)
        
        
        
        
        viewHeightConstraint = self.heightAnchor.constraint(equalToConstant: screenSize.height * defaultMultiplierOfHeight)
        viewWidthConsstraint = self.widthAnchor.constraint(equalToConstant: screenSize.width)
        navViewContainer.centerXAnchor.constraint(equalTo:         container.contentView.centerXAnchor).isActive = true
        navViewContainer.bottomAnchor.constraint(equalTo:         container.contentView.bottomAnchor, constant: -10).isActive = true
        
        NSLayoutConstraint.activate([
            viewWidthConsstraint,
            viewHeightConstraint,
            self.topAnchor.constraint(equalTo: container.topAnchor),
            container.heightAnchor.constraint(equalToConstant: screenSize.height * defaultMultiplierOfHeight),
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo:         container.contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo:         container.contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo:         container.contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo:         container.contentView.trailingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: searchFieldContainer.topAnchor, constant: 3),
            searchField.bottomAnchor.constraint(equalTo: searchFieldContainer.bottomAnchor, constant: -3),
            searchField.leadingAnchor.constraint(equalTo: searchFieldContainer.leadingAnchor, constant: 5),
            searchField.trailingAnchor.constraint(equalTo: searchFieldContainer.trailingAnchor, constant: -5),
        ])
        NSLayoutConstraint.activate([
            searchFieldContainer.widthAnchor.constraint(equalToConstant: screenSize.width * 0.75),
            searchFieldContainer.heightAnchor.constraint(equalToConstant: searchField.intrinsicContentSize.height + 10)
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: cancelButtonContainer.topAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: cancelButtonContainer.bottomAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: cancelButtonContainer.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: cancelButtonContainer.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            cancelButtonContainer.widthAnchor.constraint(equalToConstant: screenSize.width * 0.15),
            cancelButtonContainer.heightAnchor.constraint(equalToConstant: cancelButton.intrinsicContentSize.height + 10)
        ])
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
