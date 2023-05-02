//
//  BoardViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/04.
//

import UIKit

class BoardViewController: UIViewController {
    
    //MARK: - DATA
    var repository: BoardViewRepository?
    var boardName: String = "유머" {
        didSet{
            loadData()
        }
    }
    var info: BoardInfoData? {
        didSet{
            // should assign UI Label
            boardTapView.tapList = info?.tapList ?? []
            boardDescription.text = info?.boardDescription
            info?.boardLevel
            info?.boardHotKeyword
            boardTitle.text = info?.boardName
            info?.boardOwnerID
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    var posts: [BoardPostMetaData]? {
        didSet{
            // should assign data to the BoardTableView
            
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    private var isLoading: Bool = false
    
    //MARK: - UI Components
    let contentScrollView: UIScrollView = UIScrollView()
    let boardTableView: BoardTableView = BoardTableView()
    let boardNavBar: BoardNavBar = BoardNavBar()
    let boardTapView: BoardTapView = BoardTapView()
    let boardTitle: UILabel = UILabel()
    let boardDescription: UILabel = UILabel()
    let contents: UIStackView = UIStackView()
    
    private func transAuto(){
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        boardTableView.translatesAutoresizingMaskIntoConstraints = false
        boardNavBar.translatesAutoresizingMaskIntoConstraints = false
        boardTapView.translatesAutoresizingMaskIntoConstraints = false
        boardTitle.translatesAutoresizingMaskIntoConstraints = false
        boardDescription.translatesAutoresizingMaskIntoConstraints = false
        contents.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews(){
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contents)
        view.addSubview(boardTapView)
        view.addSubview(boardNavBar)
        contents.addArrangedSubview(boardTitle)
        contents.addArrangedSubview(boardDescription)
        contents.addArrangedSubview(boardTableView)
    }
    private func configure(){
        contentScrollView.delegate = self
        boardTableView.isScrollEnabled = false
        contents.axis = .vertical
        contents.distribution = .fill
        contentScrollView.backgroundColor = .systemBackground
        boardTableView.didCellClicked = { str in
            // Should Navigate To PostVC
            print(str)
        }
        boardTapView.cellClicked = { str in
            // Should Filter Posts According to the taps
            let s: String = str ?? "Tap List Empty"
            print(s)
        }
        
    }
    
    
    private func layout(){
        NSLayoutConstraint.activate([
            boardTapView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05),
            boardTapView.widthAnchor.constraint(equalToConstant: view.frame.width),
            boardTapView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.12)
        ])
        NSLayoutConstraint.activate([
            boardNavBar.topAnchor.constraint(equalTo: view.topAnchor),
            boardNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.17),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            boardTitle.heightAnchor.constraint(equalToConstant: view.frame.height*0.05),
            boardDescription.heightAnchor.constraint(equalToConstant: view.frame.height*0.1)
        ])
        NSLayoutConstraint.activate([
            contents.widthAnchor.constraint(equalToConstant: view.frame.width),
            contents.topAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.topAnchor),
            contents.leadingAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.leadingAnchor),
            contents.trailingAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.trailingAnchor),
            contents.bottomAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
        ])
    }
    private func loadData(){
        Task.init {
            do{
                self.info = try await repository?.getBoardInfoData(name: boardName)
                self.posts = try await repository?.getBoardPosts(name: boardName, start: "NaN")
                //Relayout
            }catch{
                print(">>>> BOARD VIEW ERROR: Could Not Load Data - \(error)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = BoardViewRepositoryImpl()
        loadData()
        transAuto()
        addSubviews()
        configure()
        layout()
        
    }
    
}

extension BoardViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if isLoading{
            return
        }
        if position > (boardTableView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            // make isLoading true
            isLoading = true
            
            // reload and append data
            
            print("bottom")
        }
    }
}


