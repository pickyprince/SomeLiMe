//
//  ViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/02/24.
//

import UIKit


// MARK: - Fixtures
fileprivate enum HomeViewData {
    static let realTimeHotHeader: String = "실시간 HOT 트렌드"
    static let realTimeHotButtonTitle: String = ""
    static let realTimeHotButtonImage: UIImage? = UIImage(systemName: "chevron.right")
    static let realTimeHotRanking: [String] = ["1.야구", "2.축구", "3.농구", "4.배구", "5.야구대회", "6.축구대회", "7.네이버공채", "8.이그젬플10", "9.네이버공채", "10.알고리즘"]
    
    static let realTimeBoardHeader: String = "게시판 순위"
    static let realTimeBoardButtonTitle: String = ""
    static let realTimeBoardButtonImage: UIImage? = UIImage(systemName: "chevron.right")
    static let realTimeBoardRanking: [String] = ["1.게시판", "2.축구게시판", "3.농구게시판", "4.배구게시판", "5.야구대회", "6.축구대회", "7.네이버공채", "8.이그젬플10", "9.네이버공채", "10.알고리즘"]
    
    static let categoryHeader: String = "카테고리"
    static let categoryButtonTitle: String = "Req"
    static let categoryList: [String] = ["게시판", "축구게시판", "농구게시판", "배구게시판", "야구대회", "축구대회", "네이버공채", "이그젬플", "네이버공채", "알고리즘"]
    static let defaultSelectedCategory: String = categoryList[0]
    
    static let dropDownList: [String] = ["A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장", "A타입 광장", "B타입 광장","C타입 광장"]
}


final class HomeViewController: UIViewController {
    
    
    // MARK: - UI Object Views Properties List
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let realTimeHotRankSectionView: LabelCollectionView = LabelCollectionView()
    
    let realTimeBoardRankSectionView: LabelCollectionView = LabelCollectionView()
    
    let navBar: HomeNavBar = HomeNavBar()
    
    fileprivate var selectedCategory: String = HomeViewData.defaultSelectedCategory {
        didSet {
            print(selectedCategory)
        }
    }
    
    
    
    let categorySectionView: CategorySectionView = {
        let view = CategorySectionView()
        return view
    }()
    
    private var isDropDown: Bool = false
    @objc func dropDownButtonTouchUp(){
    }
    
    func test(){
        for _ in 1...10{
            let view = UIView()
            view.backgroundColor = .gray
            view.heightAnchor.constraint(equalToConstant: 100).isActive = true
            contentView.addArrangedSubview(view)
        }
    }
    
    // MARK: - UI Configuration and Setup
    func configure(){
        
        //DATA ASSIGNMENT
        realTimeHotRankSectionView.titleString = HomeViewData.realTimeHotHeader
        realTimeHotRankSectionView.data = HomeViewData.realTimeHotRanking
        realTimeHotRankSectionView.buttonTitleString = HomeViewData.realTimeHotButtonTitle
        realTimeHotRankSectionView.buttonImage = HomeViewData.realTimeHotButtonImage

        realTimeBoardRankSectionView.titleString = HomeViewData.realTimeBoardHeader
        realTimeBoardRankSectionView.data = HomeViewData.realTimeBoardRanking
        realTimeBoardRankSectionView.buttonTitleString = HomeViewData.realTimeBoardButtonTitle
        realTimeBoardRankSectionView.buttonImage = HomeViewData.realTimeBoardButtonImage

        categorySectionView.titleString = HomeViewData.categoryHeader
        categorySectionView.data = HomeViewData.categoryList
        categorySectionView.buttonTitleString = HomeViewData.categoryButtonTitle
        
        
        //Navigation Disable
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        //VIEW CONFIGURATION
        view.backgroundColor = .systemBackground
        contentView.axis = .vertical
        contentView.spacing = 15
        contentView.distribution = .fill
        
        //ADD SUBVIEWS
        view.addSubview(scrollView)
        view.addSubview(navBar)
        
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(realTimeHotRankSectionView)
        contentView.addArrangedSubview(realTimeBoardRankSectionView)
        contentView.addArrangedSubview(categorySectionView)
        test()
        
    }
    
    // MARK: - UI Layout Setup
    func setupLayout(){
        NSLayoutConstraint.activate([
            
            navBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            navBar.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.12)
            
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
        
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupLayout()
    }
}


