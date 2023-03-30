//
//  HomeViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/24.
//

import UIKit

fileprivate enum HomeViewData {
    static let realTimeHotHeader: String = "실시간 HOT 트렌드"
    static let realTimeHotButtonTitle: String = ""
    static let realTimeHotButtonImage: UIImage? = UIImage(systemName: "chevron.right")
    
    static let realTimeBoardHeader: String = "게시판 순위"
    static let realTimeBoardButtonTitle: String = ""
    static let realTimeBoardButtonImage: UIImage? = UIImage(systemName: "chevron.right")
    
    static let categoryHeader: String = "카테고리"
    static let categoryButtonTitle: String = "Req"
    
    static let dropDownList: [String] = ["A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장"]
    
    static let boardTitle: String = "광장게시판"
    
}

class HomeViewController: UIViewController {
    
    var repository: HomeViewRepository? = nil
    
    let scrollView: UIScrollView = UIScrollView()
    
    let contentView: UIStackView = UIStackView()
    
    let realTimeHotRankSectionView: LabelCollectionView = LabelCollectionView()
    
    let realTimeBoardRankSectionView: LabelCollectionView = LabelCollectionView()
    
    let boardSectionView: BoardSectionView = BoardSectionView()
    
    let navBar: HomeNavBar = HomeNavBar()
    
    let categorySectionView: CategorySectionView = CategorySectionView()
    
    
    //call back functions
    public var sideMenuTouched: (()->())?
    
    public var profileTouched: (()->())?
    
    public var fogTouched: (()->())?
    
    let fogView: UIButton = {
        let view = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .black
        view.layer.opacity = 0.3
        return view
    }()
    let emptyViewBoxForNavigationSpace: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func searchButtonTouchUp(){
        print("search button clicked!")
        UIView.animate(withDuration: 0.3, animations: {
            
            self.scrollView.layer.opacity -= 1
            self.navBar.layer.opacity -= 1
            
        }, completion: { isComp in
            if isComp {
                let view = SearchViewController()
                view.navBar.layer.opacity = 0
                view.scrollView.layer.opacity = 0
                self.navigationController?.pushViewController(view, animated: false)
                self.scrollView.layer.opacity = 1
                self.navBar.layer.opacity = 1
                UIView.animate(withDuration: 0.3, animations: {
                    view.navBar.layer.opacity += 1
                    view.scrollView.layer.opacity += 1
                })
            }
            
        })
    }
    
    @objc func sideMenuButtonTouchUp(){
        print("sideMenuButton Clicked")
        self.view.addSubview(self.fogView)
        sideMenuTouched?()
    }
    
    @objc func profileButtonTouchUp(){
        print("profileButtonClicked")
        self.view.addSubview(self.fogView)
        profileTouched?()
            
    }
    
    @objc func fogTouchUP(){
        print("fogViewTouched!")
        fogView.removeFromSuperview()
        fogTouched?()
        
    }
    
    func test(){
        for _ in 1...10 {
            let view = UIView()
            view.backgroundColor = .gray
            view.heightAnchor.constraint(equalToConstant: 100).isActive = true
            contentView.addArrangedSubview(view)
        }
    }
    
    func loadData(){
        
        //DATA ASSIGNMENT
        realTimeHotRankSectionView.titleLabelString = HomeViewData.realTimeHotHeader
        realTimeHotRankSectionView.data = repository?.getHotTrendData()?.realTimeHotRanking ?? []
        realTimeHotRankSectionView.buttonTitleString = HomeViewData.realTimeHotButtonTitle
        realTimeHotRankSectionView.buttonImage = HomeViewData.realTimeHotButtonImage

        realTimeBoardRankSectionView.titleLabelString = HomeViewData.realTimeBoardHeader
        realTimeBoardRankSectionView.data = repository?.getHotBoardRankingData()?.realTimeBoardRanking ?? []
        realTimeBoardRankSectionView.buttonTitleString = HomeViewData.realTimeBoardButtonTitle
        realTimeBoardRankSectionView.buttonImage = HomeViewData.realTimeBoardButtonImage

        categorySectionView.titleString = HomeViewData.categoryHeader
        categorySectionView.data = repository?.getCategoryData()?.list ?? []
        categorySectionView.buttonTitleString = HomeViewData.categoryButtonTitle
        
    }
    
    // MARK: - UI Configuration and Setup
    func configure(){
        
        //Navigation Disable
        self.navigationController?.navigationBar.isHidden = true
        
        
        //VIEW CONFIGURATION
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBackground
        contentView.axis = .vertical
        contentView.spacing = 15
        contentView.distribution = .fill
        navBar.delegate = self
        fogView.addTarget(self, action: #selector(fogTouchUP), for: .touchUpInside)
        
        
        //Router
        realTimeHotRankSectionView.detailButtonClicked = {
            self.navigationController?.pushViewController(RealTimeHotDetailViewController(), animated: true)
        }
        realTimeBoardRankSectionView.detailButtonClicked = {
            self.navigationController?.pushViewController(RealTimeHotDetailViewController(), animated: true)
        }
        
        //ADD SUBVIEWS
        view.addSubview(scrollView)
        view.addSubview(navBar)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(emptyViewBoxForNavigationSpace)
        contentView.addArrangedSubview(realTimeHotRankSectionView)
        contentView.addArrangedSubview(realTimeBoardRankSectionView)
        contentView.addArrangedSubview(categorySectionView)
        contentView.addArrangedSubview(boardSectionView)
        
        
    }
    
    // MARK: - UI Layout Setup
    func setupLayout(){
        
        emptyViewBoxForNavigationSpace.heightAnchor.constraint(equalToConstant: self.view.frame.height*0.05 - contentView.spacing).isActive = true
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
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
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupLayout()
    }
    
    

}
