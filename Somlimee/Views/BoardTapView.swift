//
//  BoardTapView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/22.
//

import UIKit

class BoardTapView: UIView {
    
    // MARK: - Contents Data
    public var tapList: [String]?{
        didSet{
            collectionView.reloadData()
            collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .init())
        }
    }
    // MARK: - UI Objects
    
    var cellClicked: ((String?) -> Void)?
    
    private let collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(BoardTapViewCell.self, forCellWithReuseIdentifier: "cellID")
        return collectionView
    }()
    
    private func internalInit(){
        collectionView.delegate = self
        collectionView.dataSource = self
        configure()
        setUpLayout()
    }
    private func configure(){
        collectionView.isScrollEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    private func setUpLayout() {
        
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor)
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
extension BoardTapView: UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tapList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! BoardTapViewCell
        cell.index = indexPath.item
        cell.text = tapList?[indexPath.item] ?? ""
        return cell
    }
    
}
extension BoardTapView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BoardTapViewCell
        cellClicked?(cell.cellLabel.text)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let button = UIButton()
        button.setTitle(tapList?[indexPath.item] ?? "", for: .normal)
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
class BoardTapViewCell: UICollectionViewCell {
    var cellColor: UIColor = .systemBackground
    var index: Int = 0
    var text : String = "" {didSet{cellLabel.text = text}}
    override var isSelected: Bool {
        didSet{
            if isSelected{
                self.cellColor = .systemGreen
            }else{
                self.cellColor = .systemBackground
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


