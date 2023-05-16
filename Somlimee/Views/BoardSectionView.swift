//
//  BoardSectionView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/18.
//

import UIKit

class BoardSectionView: UIStackView{
    
    //MARK: - DATA
    var data: BoardInfoData? {
        didSet{
            hotKeywordsList =  data?.boardHotKeyword ?? ["Could Not Load"]
            boardDescription = data?.boardDescription ?? "Could Not Load"
            boardTitle = data?.boardName ?? "Could Not Load"
            boardLevel = data?.boardLevel ?? 404
            hotKeyWordsSection.data = hotKeywordsList
            boardTitleLabel.text = boardTitle
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    var tableData: [BoardPostMetaData]? {
        didSet{
            self.boardTableView.boardSectionPostCellData = tableData
            boardTableView.reloadData()
        }
    }
    var didPostClicked: ((String)->Void)? {
        didSet{
            
            boardTableView.didCellClicked = didPostClicked
        }
    }
    var onNavigateButtonClicked: (()->Void)?
    
    @objc private func moveToBoard(){
        onNavigateButtonClicked?()
    }
    private var boardTitle: String = ""
    
    private var hotKeywordsList: [String] = []
    
    private var hotKeywordsHeader: String = "실시간 HOT 키워드"
    
    private var boardDescription: String = ""
    
    private var boardLevel: Int = 0
    
    //MARK: - UI Objects Declaration
    private let boardTitleView: UIStackView = UIStackView()
    
    private let boardTitleLabel: UILabel = UILabel()
    
    private let boardButtonGroup: UIStackView = UIStackView()
    
    private let boardSettingButton: UIButton = UIButton()
    
    private let boardNavButton: UIButton = UIButton()
    
    private let hotKeyWordsSection: LabelCollectionView = LabelCollectionView()
    
    private let boardTableView: HomeBoardTableView = HomeBoardTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        boardTitleLabel.text = boardTitle
        hotKeyWordsSection.titleLabelString = hotKeywordsHeader
        hotKeyWordsSection.data = hotKeywordsList
        boardTitleView.translatesAutoresizingMaskIntoConstraints = false
        boardTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        boardTableView.translatesAutoresizingMaskIntoConstraints = false
        hotKeyWordsSection.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .fill
        self.axis = .vertical
        self.addArrangedSubview(boardTitleView)
        self.addArrangedSubview(hotKeyWordsSection)
        self.addArrangedSubview(boardTableView)
        boardButtonGroup.distribution = .fillEqually
        
        boardTitleView.addArrangedSubview(boardTitleLabel)
        boardTitleView.addArrangedSubview(boardButtonGroup)
        boardTitleView.distribution = .equalSpacing
        boardNavButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        boardNavButton.tintColor = .label
        boardNavButton.addTarget(self, action: #selector(moveToBoard), for: .touchUpInside)
        boardButtonGroup.addArrangedSubview(boardNavButton)
        boardButtonGroup.addArrangedSubview(boardSettingButton)
        boardSettingButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        boardSettingButton.tintColor = .label
        boardTableView.didCellClicked = didPostClicked
        
        
        NSLayoutConstraint.activate([
            boardTableView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
