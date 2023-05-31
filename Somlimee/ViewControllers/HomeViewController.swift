//
//  HomeViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/24.
//

import UIKit
import FirebaseAuth

fileprivate enum HomeViewStaticData {
    
    
}

class HomeViewController: UIViewController {
    
    //Base
    var repository: HomeViewRepository?
    
    let scrollView: UIScrollView = UIScrollView()
    
    let contentView: UIStackView = UIStackView()
    
    // MyLimeVIew
    let myLimeRoomView: MyLimeRoomNotLoggedView = MyLimeRoomNotLoggedView()
    
    //Lime Trends Section
    let limeTrendsContainer: UIStackView = UIStackView()
    
    let limeTrendTitle: UILabel = UILabel()
    
//    let limeTrendCollectionView: LimeTrendCollectionView = LimeTrendCollectionView()
    
    
    let limesToday: BoardSectionView = BoardSectionView()
    
    let navBar: HomeNavBar = HomeNavBar()
    
    let categorySectionView: CategorySectionView = CategorySectionView()
    
    var currentCategory: String = "유머"
    
    var scrollViewTopConstraint: NSLayoutConstraint?
    //call back functions
    var sideMenuTouched: (()->())?
    
    var profileTouched: (()->())?
    
    var fogTouched: (()->())?
    
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
        
//        categorySectionView.titleString = "광장"
//        categorySectionView.buttonTitleString = HomeViewStaticData.categoryButtonTitle
        categorySectionView.cellClicked = { str in
            
            print("cell clicked \(str ?? "")")
            self.currentCategory = str ?? ""
            Task.init {
                do{
                    self.limesToday.data = try await self.repository?.getBoardInfoData(name: self.currentCategory)
                    self.limesToday.tableData = try await self.repository?.getBoardPostMetaList(boardName: self.currentCategory, startTime: "NaN")
                    
                }catch{
                    print(">>>> ERROR: \(error)")
                    self.limesToday.data = BoardInfoData(boardName: "ERROR", boardOwnerID: "", tapList: [], boardLevel: 404, boardDescription: "ERROR", boardHotKeyword: ["ERROR"])
                    self.limesToday.tableData = []
                    
                }
            }
            print(">>>> LOADING HOMEVIEW RT DATA SUCCEEDED...")
        }
        navBar.dropDownTableClicked = { name in
            let boardV = BoardViewController()
            boardV.boardName = name
            boardV.boardNavBar.title.text = name
            self.navBar.isDropDown = false
            self.navigationController?.pushViewController(boardV, animated: true)
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
        navBar.title.text = "SomLiMe"
        fogView.addTarget(self, action: #selector(fogTouchUP), for: .touchUpInside)
        
        
        //Router
        limesToday.didPostClicked = { str in
            let boardV = BoardPostViewController()
            boardV.boardName = self.currentCategory
            boardV.postId = str
            self.navigationController?.pushViewController(boardV, animated: true)
        }
        limesToday.onNavigateButtonClicked = {
            let boardV = BoardViewController()
            boardV.boardName = self.currentCategory
            self.navigationController?.pushViewController(boardV, animated: true)
        }
        //ADD SUBVIEWS
        view.addSubview(scrollView)
        view.addSubview(navBar)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(emptyViewBoxForNavigationSpace)
        contentView.addArrangedSubview(myLimeRoomView)
        contentView.addArrangedSubview(categorySectionView)
        contentView.addArrangedSubview(limesToday)
        
        
    }
    
    // MARK: - UI Layout Setup
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        emptyViewBoxForNavigationSpace.heightAnchor.constraint(equalTo: navBar.heightAnchor, multiplier: 0.5).isActive = true
        
        self.scrollViewTopConstraint = scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
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
