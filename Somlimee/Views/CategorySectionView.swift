//
//  CategorySectionView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/09.
//


import UIKit

// MARK: - Customized Title With Horizontal Collection View
class CategorySectionView: UIView {
    
    
    
    
    // MARK: - Contents Data
    public var titleString: String = "" {didSet {self.headerLabel.text = titleString}}
    public var data: [String] = [] {
        didSet{
            collectionView.reloadData()
            
            
            collectionView.selectItem(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: .init())
        }
    }
    public var buttonTitleString: String = "" {didSet{self.topRightButton.setTitle(buttonTitleString, for: .normal)}}
    public var buttonImage: UIImage? = nil {
        didSet{
            guard let image = buttonImage else{return}
            self.topRightButton.setImage(image, for: .normal)
        }
    }
    private var isExpanded: Bool = false
    private var selectColor: UIColor = .blue
    private var selectedIndex: Int = 0
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
    
    var collectionViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    private let expandButton: UIButton = {
        let button = UIButton()
        return button
    }()
    @objc private func onTouchDown(){
        self.expandButton.backgroundColor = .systemGray2
    }
    @objc private func onTouchUp(){
        self.expandButton.backgroundColor = .systemGray5
        if isExpanded {
            expandButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            
            collectionViewHeightConstraint.isActive = false
            collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: {let temp = UILabel();temp.text = "-";return temp.intrinsicContentSize.height }() * 2 + 16)
            collectionViewHeightConstraint.isActive = true
            isExpanded = false
            
        }else{
            expandButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            
            collectionViewHeightConstraint.isActive = false
            collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: {let temp = UILabel();temp.text = "-";return temp.intrinsicContentSize.height }() * 4 + 22)
            collectionViewHeightConstraint.isActive = true
            isExpanded = true
        }
        
        
    }
    var cellClicked: ((String?) -> Void)?
    
    private let collectionViewContainer: UIStackView = UIStackView()
    
    private let collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CategorySectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        
        return collectionView
    }()
    
    private func internalInit(){
        collectionView.delegate = self
        collectionView.dataSource = self
        configure()
        setUpLayout()
    }
    private func configure(){
        topRightButton.setTitleColor(.systemBlue, for: .normal)
        topRightButton.tintColor = .systemCyan
        container.distribution = .fill
        container.axis = .vertical
        //        collectionView.backgroundColor = .blue
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .systemGray6
        collectionView.layer.cornerRadius = 5
        collectionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        topRightButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        
        expandButton.tintColor = .label
        expandButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        expandButton.backgroundColor = .systemGray5
        expandButton.addTarget(self, action: #selector(onTouchDown) , for: .touchDown)
        expandButton.addTarget(self, action: #selector(onTouchUp) , for: .touchUpInside)
        expandButton.layer.cornerRadius = 5
        expandButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
        
    }
    private func setUpLayout() {
        
        self.addSubview(container)
        headerSectionView.addSubview(headerLabel)
        headerSectionView.addSubview(topRightButton)
        container.addArrangedSubview(headerSectionView)
        container.addArrangedSubview(collectionView)
        container.addArrangedSubview(expandButton)
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: {let temp = UILabel();temp.text = "-";return temp.intrinsicContentSize.height }() * 2 + 16)
        
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
            collectionViewHeightConstraint,
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            expandButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            expandButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        internalInit()
    }
}
// MARK: - DataSource and Delegate Method
extension CategorySectionView: UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CategorySectionViewCell
        cell.index = indexPath.item
        cell.text = data[indexPath.item]
        return cell
    }
    
}
extension CategorySectionView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategorySectionViewCell
        cellClicked?(cell.cellLabel.text)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let button = UIButton()
        button.setTitle(data[indexPath.item], for: .normal)
        return CGSize(width: (button.intrinsicContentSize.width + 10), height: button.intrinsicContentSize.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}



// MARK: - Cell
class CategorySectionViewCell: UICollectionViewCell {
    var cellColor: UIColor = .systemGray3
    var index: Int = 0
    var text : String = "" {didSet{cellLabel.text = text}}
    override var isSelected: Bool {
        didSet{
            if isSelected{
                self.cellColor = .systemGreen
            }else{
                self.cellColor = .systemGray3
            }
            container.backgroundColor = cellColor
        }
    }
    let container: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    let cellLabel: UILabel = {
        let button = UILabel()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.textColor = .label
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        container.backgroundColor = cellColor
        
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

