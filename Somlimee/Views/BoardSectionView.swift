//
//  BoardSectionView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/18.
//

import UIKit

class BoardSectionView: UIStackView{
    
    //MARK: - DATA
    public var boardTitle: String = "축구게시판"
    
    public var hotKeywordsList: [String] = ["롤", "트와이스", "방탄소년단"]
    
    public var hotKeywordsHeader: String = "실시간 HOT 키워드"
    
    public var boardDescription: String = "이 게시판은 축구 게시판입니다."
    
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
