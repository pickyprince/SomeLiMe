//
//  ProfileView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/23.
//

import UIKit
import FirebaseAuth


class ProfileViewController: UIViewController {
    
    //MARK: - Data
    let loadedData: ProfileData = ProfileData(userName: "sadFrog1233", profileImage: UIImage(named: "sadfrog"), totalUps: 10, receivedUps: 13, points: 1000, daysOfActive: 138, badges: ["First Follower"], personalityTestResult: PersonalityTestResultData(concentration: 10.0, humorous: 20.0, gonggam: 30.0, logic: 10.0), recentPostsNumber: 30, recentPostList: [["title": "asdfasdf", "date": NSDate()], ["title": "asdfadf", "date": NSDate()]])
    
    //MARK: - Props
    let profileImageView: UIImageView = UIImageView()
    let userNameLabel: UILabel = UILabel()
    let profileSettingButton: UIButton = UIButton()
    let giveUpsLabel: UILabel = UILabel()
    let receivedUpsLabel: UILabel = UILabel()
    let pointsLabel: UILabel = UILabel()
    let activeLabel: UILabel = UILabel()
    let badgeView: UIView = UIView()
    let testResultContainer: UIView = UIView()
    let testResultTitleLabel: UILabel = UILabel()
    let testResultDetailButton: UIButton = UIButton()
    let testResultChartView: UIView = UIView()
    let recentPostsLabel: UILabel = UILabel()
    let recentPostsNumberLabel: UILabel = UILabel()
    let recentPostsListContainer: UIStackView = UIStackView()
    let recentPostsDetailButton: UIButton = UIButton()
    let bottomButtonGroup: UIStackView = UIStackView()
    let alarmButton: UIButton = UIButton()
    var isAlarmSet: Bool = false
    let mailButton: UIButton = UIButton()
    var defaultFont: UIFont = UIFont()
    
    private func createPostListItem(){
        for data in loadedData.recentPostList{
            let postItemContainer = UIView()
            postItemContainer.translatesAutoresizingMaskIntoConstraints = false
            let date = UILabel()
            date.translatesAutoresizingMaskIntoConstraints = false
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            
            let dateString = (data["date"] as? NSDate)?.description ?? "123213123123"
            let resultString = String(dateString[dateString.startIndex...dateString.index(dateString.startIndex, offsetBy: 9)])
            date.text = resultString
            title.text = data["title"] as? String
            
            
            postItemContainer.addSubview(date)
            postItemContainer.addSubview(title)
            
            
            NSLayoutConstraint.activate([
                title.leadingAnchor.constraint(equalTo: postItemContainer.leadingAnchor, constant: 10),
                title.centerYAnchor.constraint(equalTo: postItemContainer.centerYAnchor),
                title.trailingAnchor.constraint(greaterThanOrEqualTo: date.leadingAnchor, constant: 5)
            ])
            
            NSLayoutConstraint.activate([
                date.trailingAnchor.constraint(equalTo: postItemContainer.trailingAnchor, constant: -10),
                date.centerYAnchor.constraint(equalTo: postItemContainer.centerYAnchor)
            ])
            postItemContainer.backgroundColor = .systemGray4
            recentPostsListContainer.addArrangedSubview(postItemContainer)
        }
        
    }
    @objc func profileSettingButtonTouchUp(){
        print("profile button clicked")
            do { try UserLoginService.sharedInstance.logOut()
            } catch{
                print("logout error")
            }
        
        
    }
    
    @objc func testResultDetailButtonTouchUp(){
        print("test result detail button clicked")
    }
    @objc func recentPostDetailButtonTouchUp(){
        print("recent post detail button clicked")
    }
    
    @objc func alarmButtonTouchUp(){
        if isAlarmSet{
            alarmButton.setImage(UIImage(systemName: "bell"), for: .normal)
            isAlarmSet = false
            alarmButton.layoutIfNeeded()
        }else{
            
            alarmButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
            isAlarmSet = true
            alarmButton.layoutIfNeeded()
        }
        print("alarmButton button clicked")
        
    }
    @objc func mailButtonTouchUp(){
        
        print("alarmButton button clicked")
    }
    
    //    private func loadData(){
    //        self.view.loadedData = Repository.userProfileData
    //    }
    
    
    // Not Logged In Props
    let loginButton: UIButton = UIButton()
    let verifyEmailButton: UIButton = UIButton()
    
    var navigateToLogin: (()->())?
    
    @objc func navigateToLoginView(){
        navigateToLogin?()
    }
    var navigateToVerifyEmail: (()->())?
    
    @objc func navigateToVerifyEmailView(){
        navigateToVerifyEmail?()
    }
    
    private func configureUI(){
        
        //ADD SUBVIEWS
        self.view.addSubview(loginButton)
        self.view.addSubview(verifyEmailButton)
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(recentPostsListContainer)
        self.view.addSubview(profileImageView)
        self.view.addSubview(userNameLabel)
        self.view.addSubview(profileSettingButton)
        self.view.addSubview(giveUpsLabel)
        self.view.addSubview(receivedUpsLabel)
        self.view.addSubview(pointsLabel)
        self.view.addSubview(activeLabel)
        self.view.addSubview(badgeView)
        self.view.addSubview(testResultContainer)
        testResultContainer.addSubview(testResultTitleLabel)
        testResultContainer.addSubview(testResultDetailButton)
        testResultContainer.addSubview(testResultChartView)
        self.view.addSubview(recentPostsLabel)
        self.view.addSubview(recentPostsNumberLabel)
        self.view.addSubview(recentPostsListContainer)
        self.view.addSubview(recentPostsDetailButton)
        self.view.addSubview(bottomButtonGroup)
        bottomButtonGroup.addArrangedSubview(alarmButton)
        bottomButtonGroup.addArrangedSubview(mailButton)
        
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileSettingButton.translatesAutoresizingMaskIntoConstraints = false
        giveUpsLabel.translatesAutoresizingMaskIntoConstraints = false
        receivedUpsLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        activeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        testResultContainer.translatesAutoresizingMaskIntoConstraints = false
        testResultTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        testResultDetailButton.translatesAutoresizingMaskIntoConstraints = false
        testResultChartView.translatesAutoresizingMaskIntoConstraints = false
        recentPostsLabel.translatesAutoresizingMaskIntoConstraints = false
        recentPostsNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        recentPostsListContainer.translatesAutoresizingMaskIntoConstraints = false
        recentPostsDetailButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButtonGroup.translatesAutoresizingMaskIntoConstraints = false
        alarmButton.translatesAutoresizingMaskIntoConstraints = false
        mailButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        verifyEmailButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        loginButton.setTitle("로그인하기", for: .normal)
        loginButton.setTitleColor(.label, for: .normal)
        loginButton.addTarget(self, action: #selector(navigateToLoginView), for: .touchUpInside)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        verifyEmailButton.setTitle("이메일 인증", for: .normal)
        verifyEmailButton.setTitleColor(.label, for: .normal)
        verifyEmailButton.addTarget(self, action: #selector(navigateToVerifyEmailView), for: .touchUpInside)
        
        defaultFont = UIFont.systemFont(ofSize: 13)
        profileImageView.image = UIImage(systemName: "person.fill")
        userNameLabel.text = loadedData.userName
        profileSettingButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        profileSettingButton.tintColor = .label
        profileSettingButton.addTarget(self, action: #selector(profileSettingButtonTouchUp), for: .touchUpInside)
        giveUpsLabel.text = "준 추천수 \(loadedData.totalUps)"
        giveUpsLabel.font = defaultFont
        receivedUpsLabel.text = "받은 추천수 \(loadedData.receivedUps)"
        receivedUpsLabel.font = defaultFont
        pointsLabel.text = "포인트 \(loadedData.points)"
        pointsLabel.font = defaultFont
        activeLabel.text = "활동 일 수 \(loadedData.daysOfActive)"
        activeLabel.font = defaultFont
        badgeView.backgroundColor = .orange
        testResultContainer.backgroundColor = .systemGray5
        testResultTitleLabel.text = "성격테스트 결과"
        testResultTitleLabel.font = UIFont.systemFont(ofSize: 15)
        testResultDetailButton.setTitle("detail", for: .normal)
        testResultDetailButton.setTitleColor(.label, for: .normal)
        testResultDetailButton.tintColor = .label
        testResultDetailButton.addTarget(self, action: #selector(testResultDetailButtonTouchUp), for: .touchUpInside)
        testResultChartView.backgroundColor = .gray
        recentPostsLabel.text = "최근 작성글"
        recentPostsNumberLabel.text = loadedData.recentPostsNumber.description
        createPostListItem()
        recentPostsListContainer.axis = .vertical
        recentPostsListContainer.distribution = .fillEqually
        recentPostsDetailButton.setTitle("detail", for: .normal)
        recentPostsDetailButton.tintColor = .label
        recentPostsDetailButton.setTitleColor(.label, for: .normal)
        recentPostsDetailButton.addTarget(self, action: #selector(recentPostDetailButtonTouchUp), for: .touchUpInside)
        bottomButtonGroup.axis = .horizontal
        bottomButtonGroup.distribution = .fillEqually
        alarmButton.setImage(UIImage(systemName: "bell"), for: .normal)
        alarmButton.tintColor = .label
        alarmButton.addTarget(self, action: #selector(alarmButtonTouchUp), for: .touchUpInside)
        
        mailButton.setImage(UIImage(systemName: "envelope"), for: .normal)
        mailButton.tintColor = .label
        mailButton.addTarget(self, action: #selector(mailButtonTouchUp), for: .touchUpInside)
        
        
    }
    
    private func setUpLayout(){
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height * 0.10),
            profileImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            profileSettingButton.leadingAnchor.constraint(greaterThanOrEqualTo: userNameLabel.trailingAnchor, constant: 20),
            profileSettingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            profileSettingButton.widthAnchor.constraint(equalToConstant: 40),
            profileSettingButton.heightAnchor.constraint(equalToConstant: 40),
            profileSettingButton.topAnchor.constraint(equalTo: profileImageView.topAnchor)
        ])
        NSLayoutConstraint.activate([
            giveUpsLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 3),
            giveUpsLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            receivedUpsLabel.topAnchor.constraint(equalTo: giveUpsLabel.bottomAnchor, constant: 3),
            receivedUpsLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            pointsLabel.topAnchor.constraint(equalTo: receivedUpsLabel.bottomAnchor, constant: 3),
            pointsLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            activeLabel.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 3),
            activeLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            badgeView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.1),
            badgeView.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.7 - 20),
            badgeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            badgeView.topAnchor.constraint(equalTo: activeLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            testResultContainer.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.17),
            testResultContainer.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.7 - 20),
            testResultContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            testResultContainer.topAnchor.constraint(equalTo: badgeView.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            testResultTitleLabel.topAnchor.constraint(equalTo: testResultContainer.topAnchor, constant: 10),
            testResultTitleLabel.leadingAnchor.constraint(equalTo: testResultContainer.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            testResultDetailButton.bottomAnchor.constraint(equalTo: testResultContainer.bottomAnchor, constant: -5),
            testResultDetailButton.trailingAnchor.constraint(equalTo: testResultContainer.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            testResultChartView.leadingAnchor.constraint(equalTo: testResultContainer.leadingAnchor, constant: 5),
            testResultChartView.topAnchor.constraint(equalTo: testResultTitleLabel.bottomAnchor),
            testResultChartView.bottomAnchor.constraint(equalTo: testResultDetailButton.topAnchor),
            testResultChartView.trailingAnchor.constraint(equalTo: testResultContainer.trailingAnchor, constant: -5)
        ])
        NSLayoutConstraint.activate([
            recentPostsLabel.topAnchor.constraint(equalTo: testResultContainer.bottomAnchor, constant: 10),
            recentPostsLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            recentPostsNumberLabel.topAnchor.constraint(equalTo: recentPostsLabel.topAnchor),
            recentPostsNumberLabel.leadingAnchor.constraint(equalTo: recentPostsLabel.trailingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            recentPostsListContainer.topAnchor.constraint(equalTo: recentPostsLabel.bottomAnchor, constant: 10),
            recentPostsListContainer.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            recentPostsListContainer.trailingAnchor.constraint(equalTo: testResultContainer.trailingAnchor),
            recentPostsListContainer.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
        ])
        
        NSLayoutConstraint.activate([
            recentPostsDetailButton.topAnchor.constraint(equalTo: recentPostsListContainer.bottomAnchor),
            recentPostsDetailButton.trailingAnchor.constraint(equalTo: recentPostsListContainer.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            bottomButtonGroup.topAnchor.constraint(equalTo: recentPostsDetailButton.bottomAnchor, constant: 10),
            bottomButtonGroup.centerXAnchor.constraint(equalTo: recentPostsListContainer.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            alarmButton.widthAnchor.constraint(equalToConstant: 40),
            alarmButton.heightAnchor.constraint(equalToConstant: 40),
            mailButton.widthAnchor.constraint(equalToConstant: 40),
            mailButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        NSLayoutConstraint.activate([
            verifyEmailButton.topAnchor.constraint(equalTo: bottomButtonGroup.bottomAnchor),
            verifyEmailButton.trailingAnchor.constraint(equalTo: bottomButtonGroup.trailingAnchor),
            verifyEmailButton.leadingAnchor.constraint(equalTo: bottomButtonGroup.leadingAnchor)
        ])
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try UserLoginService.sharedInstance.logOut()
        }catch{
            print("signouterror")
        }
        FirebaseAuth.Auth.auth().addStateDidChangeListener({ auth, user in
            
            if user == nil {
                self.loginButton.isHidden = false
                self.verifyEmailButton.isHidden = true
                self.profileImageView.isHidden = true
                self.userNameLabel.isHidden = true
                self.profileSettingButton.isHidden = true
                self.receivedUpsLabel.isHidden = true
                
                self.giveUpsLabel.isHidden = false
                self.pointsLabel.isHidden = true
                self.activeLabel.isHidden = true
                self.badgeView.isHidden = true
                self.testResultContainer.isHidden = true
                self.recentPostsLabel.isHidden = true
                self.recentPostsNumberLabel.isHidden = true
                self.recentPostsListContainer.isHidden = true
                self.recentPostsDetailButton.isHidden = true
                self.bottomButtonGroup.isHidden = true
            }else{
                self.loginButton.isHidden = true
                self.profileImageView.isHidden = false
                self.userNameLabel.isHidden = false
                self.profileSettingButton.isHidden = false
                self.receivedUpsLabel.isHidden = false
                
                self.giveUpsLabel.isHidden = false
                self.pointsLabel.isHidden = false
                self.activeLabel.isHidden = false
                self.badgeView.isHidden = false
                self.testResultContainer.isHidden = false
                self.recentPostsLabel.isHidden = false
                self.recentPostsNumberLabel.isHidden = false
                self.recentPostsListContainer.isHidden = false
                self.recentPostsDetailButton.isHidden = false
                self.bottomButtonGroup.isHidden = false
                guard let result = user?.isEmailVerified else{
                    return
                }
                if result{
                    self.verifyEmailButton.isHidden = false
                }else{
                    self.verifyEmailButton.isHidden = false
                }
            }
        })
        //        loadData()
        configureUI()
        setUpLayout()
        
        
        
        self.loginButton.isHidden = false
        self.profileImageView.isHidden = true
        self.userNameLabel.isHidden = true
        self.profileSettingButton.isHidden = true
        self.receivedUpsLabel.isHidden = true
        self.giveUpsLabel.isHidden = true
        self.pointsLabel.isHidden = true
        self.activeLabel.isHidden = true
        self.badgeView.isHidden = true
        self.testResultContainer.isHidden = true
        self.recentPostsLabel.isHidden = true
        self.recentPostsNumberLabel.isHidden = true
        self.recentPostsListContainer.isHidden = true
        self.recentPostsDetailButton.isHidden = true
        self.bottomButtonGroup.isHidden = true
    }
}
