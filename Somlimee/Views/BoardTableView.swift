//
//  BoardTableView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/25.
//

import UIKit

class BoardTableView: UITableView{
    
    var boardSectionPostCellData: [BoardPostMetaData]? {
        didSet{
            self.reloadData()
            heightConstraint.isActive = false
            heightConstraint = self.heightAnchor.constraint(equalToConstant: CGFloat(boardSectionPostCellData?.count ?? 0) * cellHeight)
            heightConstraint.isActive = true
        }
    }
    var didCellClicked: ((String)->Void)?
    private var heightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var cellHeight: CGFloat = 56{
        didSet{
            heightConstraint.isActive = false
            heightConstraint = self.heightAnchor.constraint(equalToConstant: CGFloat(boardSectionPostCellData?.count ?? 0) * cellHeight)
            heightConstraint.isActive = true
        }
    }
    
    private let topBottomInsets: CGFloat = 10
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        delegate = self
        
        dataSource = self
        
        self.register(HomeBoardTableViewCell.self, forCellReuseIdentifier: String(describing: HomeBoardTableViewCell.self))
        
        let label = UILabel()
        label.text = "H"
        let image = UIImageView(image: UIImage(systemName: "person.fill"))
        cellHeight = (label.intrinsicContentSize.height + image.intrinsicContentSize.height) + topBottomInsets
        
        heightConstraint = self.heightAnchor.constraint(equalToConstant: CGFloat(boardSectionPostCellData?.count ?? 0) * cellHeight)
        heightConstraint.isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension BoardTableView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardSectionPostCellData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: HomeBoardTableViewCell.self), for: indexPath) as! HomeBoardTableViewCell
        cell.postTitle = boardSectionPostCellData?[indexPath.item].postTitle ?? ""
        cell.postType = boardSectionPostCellData?[indexPath.item].postType ?? PostType.text
        cell.numberOfViews = boardSectionPostCellData?[indexPath.item].numberOfViews ?? 0
        cell.numberOfRecommendation = boardSectionPostCellData?[indexPath.item].numberOfVoteUps ?? 0
        
        Task.init {
            do{
                let userName = try await userNameParser(uid: boardSectionPostCellData?[indexPath.item].userID ?? "")
                cell.userID = userName ?? "ERROR"
            }catch{
                cell.userID = "ERROR: \(error)"
            }
        }
        cell.publishedTime = boardSectionPostCellData?[indexPath.item].publishedTime ?? ""
        cell.boardCategory = boardSectionPostCellData?[indexPath.item].boardTap ?? ""
        cell.boardID = boardSectionPostCellData?[indexPath.item].boardID ?? ""
        cell.postID = boardSectionPostCellData?[indexPath.item].postID ?? ""
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = cellForRow(at: indexPath) as! HomeBoardTableViewCell
        didCellClicked?(cell.postID ?? "")
    }
}

