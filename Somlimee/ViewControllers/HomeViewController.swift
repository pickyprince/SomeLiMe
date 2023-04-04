//
//  HomeViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/24.
//

import UIKit
import FirebaseAuth

fileprivate enum HomeViewStaticData {
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
    
    var scrollViewTopConstraint: NSLayoutConstraint?
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
        print(">>>>SEARCH BUTTON CLICKED!")
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
        print(">>>>SIDE MENU BUTTON CLICKED!")
        self.view.addSubview(self.fogView)
        sideMenuTouched?()
    }
    
    @objc func profileButtonTouchUp(){
        print(">>>>PROFILE BUTTON CLICKED!")
        self.view.addSubview(self.fogView)
        profileTouched?()
        
    }
    
    @objc func fogTouchUP(){
        print(">>>>FOGVIEW BUTTON CLICKED!")
        fogView.removeFromSuperview()
        fogTouched?()
        
    }
    @objc func handleRefreshControl() {
        // Update your content…
        loadData()
        Auth.auth().currentUser?.reload()
        // Dismiss the refresh control.
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.endRefreshing()
        }
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
        //loadTask
        Task.init {
            do{
                
                realTimeHotRankSectionView.data = try await repository?.getHotTrendData()?.realTimeHotRanking ?? []
                
                realTimeBoardRankSectionView.data = try await repository?.getHotBoardRankingData()?.realTimeBoardRanking ?? []
                
                categorySectionView.data = try await repository?.getCategoryData()?.list ?? []
                
                print(">>>> LOADING HOMEVIEW RT DATA SUCCEEDED...")
                
            } catch {
                
                print(">>>> LOADING HOMEVIEW RT DATA FAILED...")
                
            }
        }
        
        
    }
    
    // MARK: - UI Configuration and Setup
    func configure(){
        
        let refresh: UIRefreshControl = UIRefreshControl()
        self.scrollView.refreshControl = refresh
        self.scrollView.refreshControl?.addTarget(self, action:
                                                    #selector(handleRefreshControl),
                                                  for: .valueChanged)
        self.scrollView.delegate = self
        //DATA ASSIGNMENT
        realTimeHotRankSectionView.titleLabelString = HomeViewStaticData.realTimeHotHeader
        realTimeHotRankSectionView.buttonTitleString = HomeViewStaticData.realTimeHotButtonTitle
        realTimeHotRankSectionView.buttonImage = HomeViewStaticData.realTimeHotButtonImage
        realTimeHotRankSectionView.cellClicked = { str in
            print("cell clicked \(str ?? "")")
        }
        
        realTimeBoardRankSectionView.titleLabelString = HomeViewStaticData.realTimeBoardHeader
        realTimeBoardRankSectionView.buttonTitleString = HomeViewStaticData.realTimeBoardButtonTitle
        realTimeBoardRankSectionView.buttonImage = HomeViewStaticData.realTimeBoardButtonImage
        realTimeBoardRankSectionView.cellClicked = { str in
            
                print("cell clicked \(str ?? "")")
        }
        categorySectionView.titleString = HomeViewStaticData.categoryHeader
        categorySectionView.buttonTitleString = HomeViewStaticData.categoryButtonTitle
        categorySectionView.cellClicked = { str in
            
                print("cell clicked \(str ?? "")")
        }
        
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
            self.navigationController?.pushViewController(PersonalityTestViewController(), animated: true)
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
        
        self.scrollViewTopConstraint = scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10)
        NSLayoutConstraint.activate([
            scrollViewTopConstraint!,
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
        print("HomeVC view loaded!")
        loadData()
        configure()
        setupLayout()
    }
    
    
    
}
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            self.scrollViewTopConstraint?.constant = -scrollView.contentOffset.y/2
        } else {
            self.scrollViewTopConstraint?.constant = 0
        }
    }
}
