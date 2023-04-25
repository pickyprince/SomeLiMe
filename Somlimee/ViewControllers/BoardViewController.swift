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
    
    //MARK: - UI Components
    let boardTableView: BoardTableView = BoardTableView()
    let boardNavBar: BoardNavBar = BoardNavBar()
    let boardTapView: BoardTapView = BoardTapView()
    let boardTitle: UILabel = UILabel()
    let boardDescription: UILabel = UILabel()
    let tableHeader: UIStackView = UIStackView()
    
    private func transAuto(){
        boardTableView.translatesAutoresizingMaskIntoConstraints = false
        boardNavBar.translatesAutoresizingMaskIntoConstraints = false
        boardTapView.translatesAutoresizingMaskIntoConstraints = false
        boardTitle.translatesAutoresizingMaskIntoConstraints = false
        boardDescription.translatesAutoresizingMaskIntoConstraints = false
        tableHeader.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews(){
        view.addSubview(boardTableView)
        view.addSubview(boardTapView)
        view.addSubview(boardNavBar)
        tableHeader.addArrangedSubview(boardTitle)
        tableHeader.addArrangedSubview(boardDescription)
    }
    private func configure(){
        boardTableView.didScrollToBottom = {
            // Should Load Posts Data
        }
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
            boardTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.17),
            boardTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            boardTitle.heightAnchor.constraint(equalToConstant: view.frame.height*0.05),
            boardDescription.heightAnchor.constraint(equalToConstant: view.frame.height*0.1)
        ])
        NSLayoutConstraint.activate([
            tableHeader.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
        NSLayoutConstraint.activate([
        ])
    }
    private func loadData(){
        Task.init {
            do{
                self.info = try await repository?.getBoardInfoData(name: boardName)
                self.posts = try await repository?.getBoardPosts(name: boardName)
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
