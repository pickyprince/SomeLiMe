//
//  RealTimeHotTrendsView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/05.
//

import UIKit

// MARK: - Customized Title With Horizontal Collection View
class LabelCollectionView: UIView {
    // MARK: - Contents Data
    public var titleString: String = "" {didSet {self.headerLabel.text = titleString}}
    public var data: [String] = ["temp"]
    public var buttonTitleString: String = "" {didSet{self.topRightButton.setTitle(buttonTitleString, for: .normal)}}
    public var buttonImage: UIImage? = nil {
        didSet{
        guard let image = buttonImage else{return}
        self.topRightButton.setImage(image, for: .normal)
        }
    }
    // MARK: - UI Objects
    private let headerLabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    private let topRightButton = {
        let button = UIButton()
        return button
    }()
    private let headerSectionView = {
        let view = UIView()
        return view
    }()
    public let container = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let collectionViewContainer: UIStackView = UIStackView()
    
    private let collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(LabelCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        
        return collectionView
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        internalInit()
    }
    private func internalInit(){
        collectionView.delegate = self
        collectionView.dataSource = self
        configure()
        setUpLayout()
    }
    private func configure(){
        
        topRightButton.setTitleColor(.label, for: .normal)
        topRightButton.tintColor = .label
        container.distribution = .fill
        container.axis = .vertical
        collectionView.backgroundColor = .systemGray6
        collectionView.layer.cornerRadius = 5
        self.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        topRightButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    private func setUpLayout() {
        
        self.addSubview(container)
        headerSectionView.addSubview(headerLabel)
        headerSectionView.addSubview(topRightButton)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: headerSectionView.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: headerSectionView.bottomAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: headerSectionView.leadingAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            topRightButton.topAnchor.constraint(equalTo: headerSectionView.topAnchor),
            topRightButton.bottomAnchor.constraint(equalTo: headerSectionView.bottomAnchor),
            topRightButton.trailingAnchor.constraint(equalTo: headerSectionView.trailingAnchor),
            topRightButton.leadingAnchor.constraint(greaterThanOrEqualTo:headerLabel.trailingAnchor, constant: 50)
        ])

        container.addArrangedSubview(headerSectionView)
        container.addArrangedSubview(collectionView)
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor),
            container.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerSectionView.heightAnchor.constraint(equalToConstant: 30),
            headerSectionView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: {let temp = UILabel();temp.text = "fjioejf";return temp.intrinsicContentSize.height}() + 20)
        ])
        
    }
    
    
}
// MARK: - DataSource and Delegate Method
extension LabelCollectionView: UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! LabelCollectionViewCell
        cell.text = data[indexPath.item]
        return cell
    }
    
}
extension LabelCollectionView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = data[indexPath.item]
        return CGSize(width: (label.intrinsicContentSize.width + 10), height: label.intrinsicContentSize.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}



// MARK: - Cell
class LabelCollectionViewCell: UICollectionViewCell {
    
    var text : String = "" {didSet{cellLabel.text = text}}
    let container: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .systemGray5
//        view.layer.cornerRadius = 10
        return view
    }()
    let cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(container)

        container.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        container.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        container.addSubview(cellLabel)
        
        cellLabel.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        cellLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
        cellLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
