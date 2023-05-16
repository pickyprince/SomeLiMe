//
//  BoardPostViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/04.
//

import UIKit

class BoardPostViewController: UIViewController {
    var repository: BoardViewRepository?
    var postComments: [BoardPostComment]? {
        didSet{
            loadData()
        }
    }
    var postContent: BoardPostContentData? {
        didSet{
            self.paragraphView.text = postContent?.boardPostParagraph
            self.titleLabel.text = postContent?.boardPostTitle
            self.tapLabel.text = postContent?.boardPostTap
            //postContent?.boardPostImages
        }
    }
    var postMeta: BoardPostMetaData?{
        didSet{
            self.detailPublishedTimeLabel.text = postMeta?.publishedTime
            self.numberOfViewsLabel.text = postMeta?.numberOfViews.description
            
            self.userID.text = postMeta?.userID
//            self.numberOfCommentsLabel.text = postMeta?.numberOfComments.description
            self.numberOfVoteUpsLabel.text = postMeta?.numberOfVoteUps.description
        }
    }
    var boardName: String?
    
    var postId: String?{
        didSet{
            loadData()
        }
    }
    
    let scrollView: UIScrollView = UIScrollView()
    
    let contentView: UIStackView = UIStackView()
    
    let boardPostNavBar: BoardPostNavBar = BoardPostNavBar()
    
    let boardTitleContainerView: UIStackView = UIStackView()
    
    let boardTitleView: UIStackView = UIStackView()
    
    let boardTitleSecondView: UIStackView = UIStackView()
    
    let tapLabel: UILabel = UILabel()
    
    let titleLabel: UILabel = UILabel()
    
    let userID: UILabel = UILabel()
    
    let detailPublishedTimeLabel: UILabel = UILabel()
    
    let numberOfViewsLabel: UILabel = UILabel()
    
    let numberOfCommentsLabel: UILabel = UILabel()
    
    let numberOfVoteUpsLabel: UILabel = UILabel()
    
    let paragraphView: UILabel = UILabel()
    
    let voteUpButton: UIButton = UIButton()
    
    let commentsView: UIStackView = UIStackView()
    
    private func loadData(){
        Task.init {
            do {
                guard let bName = boardName else{
                    return
                }
                guard let pId = postId else{
                    return
                }
                self.postMeta = try await self.repository?.getBoardPostMeta(boardName: bName, postId: pId)
                self.postContent = try await self.repository?.getBoardPostContent(boardName: bName, postId: pId)
//                self.postComments = try await self.repository.getBoardPostComments(boardName: bName, postId: pId)
                print(">>>> 포스트뷰 로드 성공: \n\t보드 이름: \(boardName ?? "Not Found")\n\t포스트 아이디 \(postId ?? "Not Found")\n\n\t포스트 형식 데이터:\n\t\t유저 아이디:  \(postMeta?.userID as? String ?? "Not Found")\n\t\t시간: \(postMeta?.publishedTime as? String ?? "Not Found")\n\t\t포스트 타이틀: \(postMeta?.postTitle as? String ?? "Not Found") \n\t\t포스트 본문: \(postContent?.boardPostParagraph as? String ?? "Not Found")")
            } catch {
                print(">>>>>> 포스트 뷰 로드 Fail: \(error)")
            }
        }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    private func transAuto(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        boardTitleView.translatesAutoresizingMaskIntoConstraints = false
        boardTitleSecondView.translatesAutoresizingMaskIntoConstraints = false
        boardPostNavBar.translatesAutoresizingMaskIntoConstraints = false
        boardTitleContainerView.translatesAutoresizingMaskIntoConstraints = false
        tapLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        userID.translatesAutoresizingMaskIntoConstraints = false
        detailPublishedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfViewsLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfVoteUpsLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfCommentsLabel.translatesAutoresizingMaskIntoConstraints = false
        paragraphView.translatesAutoresizingMaskIntoConstraints = false
        voteUpButton.translatesAutoresizingMaskIntoConstraints = false
        commentsView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(boardTitleContainerView)
        boardTitleView.addArrangedSubview(tapLabel)
        boardTitleView.addArrangedSubview(titleLabel)
        boardTitleView.addArrangedSubview(numberOfCommentsLabel)
        boardTitleView.addArrangedSubview(detailPublishedTimeLabel)
        boardTitleSecondView.addArrangedSubview(userID)
        boardTitleSecondView.addArrangedSubview(numberOfViewsLabel)
        boardTitleSecondView.addArrangedSubview(numberOfVoteUpsLabel)
        boardTitleContainerView.addArrangedSubview(boardTitleView)
        boardTitleContainerView.addArrangedSubview(boardTitleSecondView)
        contentView.addArrangedSubview(paragraphView)
        contentView.addArrangedSubview(voteUpButton)
        contentView.addArrangedSubview(commentsView)
        view.addSubview(boardPostNavBar)
        
    }
    
    private func configureUIComponent(){
        view.backgroundColor = .systemBackground
        
        boardTitleContainerView.axis = .vertical
        
        boardTitleView.axis = .horizontal
        boardTitleView.distribution = .equalSpacing
        
        boardTitleSecondView.axis = .horizontal
        
        contentView.axis = .vertical
        contentView.alignment = .leading
        
        voteUpButton.setTitle("up", for: .normal)
        
        
        paragraphView.textAlignment = .left
        paragraphView.numberOfLines = 0
        boardPostNavBar.onTouchUpBackButton = {
            self.navigationController?.popViewController(animated: true)
        }
        addComments()
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            boardPostNavBar.topAnchor.constraint(equalTo: view.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            paragraphView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9),
            commentsView.heightAnchor.constraint(equalToConstant: view.frame.height*0.4)
        ])
        NSLayoutConstraint.activate([
            boardTitleView.heightAnchor.constraint(equalToConstant: view.frame.height*0.12)
        ])
    }
    
    private func addComments(){
        guard let comments = postComments else{
            return
        }
        for comment in comments{
            let comm = UILabel()
            comm.text = comment.text
            commentsView.addArrangedSubview(comm)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = BoardViewRepositoryImpl()
        transAuto()
        addSubviews()
        configureUIComponent()
        layout()
        
    }
}
