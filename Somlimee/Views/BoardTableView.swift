//
//  BoardTableView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/25.
//

import UIKit

class BoardTableView: UITableView{
    
    //fixtures
    let fix = BoardPostMetaData(boardID: "2939481239", postID: "320240243", publishedTime: "jieojfoeifj", postType: .text, postTitle: "재밋는 짤 .... jpg", boardTap: "자유/잡담", userID: "유저아이디", numberOfViews: 24, numberOfVoteUps: 10)
    var didScrollToBottom: (()->Void)?
    var didCellClicked: ((String)->Void)?
    private var heightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var cellHeight: CGFloat = 56{
        didSet{
            heightConstraint.isActive = false
            heightConstraint = self.heightAnchor.constraint(equalToConstant: CGFloat(boardSectionPostCellData.count) * cellHeight)
            heightConstraint.isActive = true
        }
    }
    
    private let topBottomInsets: CGFloat = 10
    public var boardSectionPostCellData: [BoardPostMetaData] = [] {
        didSet{
            
            heightConstraint.isActive = false
            heightConstraint = self.heightAnchor.constraint(equalToConstant: CGFloat(boardSectionPostCellData.count) * cellHeight)
            heightConstraint.isActive = true
        }
    }
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        boardSectionPostCellData = [fix, fix, fix,fix,fix,fix,fix,fix,fix,fix,fix,fix,fix,fix,fix,fix,fix,fix]
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        delegate = self
        
        dataSource = self
        
        self.register(HomeBoardTableViewCell.self, forCellReuseIdentifier: String(describing: HomeBoardTableViewCell.self))
        
        let label = UILabel()
        label.text = "H"
        let image = UIImageView(image: UIImage(systemName: "person.fill"))
        cellHeight = (label.intrinsicContentSize.height + image.intrinsicContentSize.height) + topBottomInsets
        
        heightConstraint = self.heightAnchor.constraint(equalToConstant: CGFloat(boardSectionPostCellData.count) * cellHeight)
        heightConstraint.isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension BoardTableView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardSectionPostCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: HomeBoardTableViewCell.self), for: indexPath) as! HomeBoardTableViewCell
        cell.postTitle = boardSectionPostCellData[indexPath.item].postTitle
        cell.postType = boardSectionPostCellData[indexPath.item].postType
        cell.numberOfViews = boardSectionPostCellData[indexPath.item].numberOfViews
        cell.numberOfRecommendation = boardSectionPostCellData[indexPath.item].numberOfVoteUps
        cell.userID = boardSectionPostCellData[indexPath.item].userID
        cell.publishedTime = boardSectionPostCellData[indexPath.item].publishedTime
        cell.boardCategory = boardSectionPostCellData[indexPath.item].boardTap
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = cellForRow(at: indexPath) as! HomeBoardTableViewCell
        didCellClicked?(cell.postID)
    }
}
extension BoardTableView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > scrollView.frame.height{
                didScrollToBottom?()
        }
    }
}

