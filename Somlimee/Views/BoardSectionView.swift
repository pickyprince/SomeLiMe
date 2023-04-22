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
    private var boardTitle: String = ""
    
    private var hotKeywordsList: [String] = []
    
    private var hotKeywordsHeader: String = "실시간 HOT 키워드"
    
    private var boardDescription: String = ""
    
    private var boardLevel: Int = 0
    //MARK: - UI Objects Declaration
    private let boardTitleView: UIView = UIView()
    
    private let boardTitleLabel: UILabel = UILabel()
    
    private let boardButtonGroup: UIStackView = UIStackView()
    
    private let boardSettingButton: UIButton = UIButton()
    
    private let hotKeyWordsSection: LabelCollectionView = LabelCollectionView()
    
    private let boardTableView: BoardTableView = BoardTableView()
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
        boardTitleView.addSubview(boardTitleLabel)
        
        
        NSLayoutConstraint.activate([
            boardTableView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            boardTitleLabel.topAnchor.constraint(equalTo: boardTitleView.topAnchor),
            boardTitleLabel.bottomAnchor.constraint(equalTo: boardTitleView.bottomAnchor),
            boardTitleLabel.leadingAnchor.constraint(equalTo: boardTitleView.leadingAnchor),
            boardTitleLabel.trailingAnchor.constraint(equalTo: boardTitleView.trailingAnchor),
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
