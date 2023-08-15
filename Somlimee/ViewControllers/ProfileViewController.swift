//
//  ProfileView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/23.
//

import UIKit
import FirebaseAuth


class ProfileViewController: UIViewController {
    
    //MARK: - Computed Properties
    

    
    var repository: ProfileViewRepository? {
        didSet{
            loadData()
        }
    }
    
    //MARK: - UI Components
    
    let profileCardView: ProfileCardView = ProfileCardView()
    let testResultContainer: UIView = UIView()
    let testResultTitleLabel: UILabel = UILabel()
    let testResultDetailButton: UIButton = UIButton()
    let testResultChartView: PTChartView = PTChartView()
    let recentPostsLabel: UILabel = UILabel()
    let recentPostsNumberLabel: UILabel = UILabel()
    let recentPostsListContainer: UIStackView = UIStackView()
    let recentPostsDetailButton: UIButton = UIButton()
    let bottomButtonGroup: UIStackView = UIStackView()
    let alarmButton: UIButton = UIButton()
    var isAlarmSet: Bool = false
    let mailButton: UIButton = UIButton()
    var defaultFont: UIFont = UIFont()
    let loginButton: UIButton = UIButton()
    let verifyEmailButton: UIButton = UIButton()
    
    let personalityTestButton: UIButton = UIButton()
    
    private func createPostListItem(){
        for data in [[:]]{
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
    
    @objc func navigateToLoginView(){
        navigateToLogin?()
    }
    
    @objc func navigateToVerifyEmailView(){
        navigateToVerifyEmail?()
    }
    
    @objc func navigateToPersonalityTestView(){
        navigateToPersonalityTest?()
    }
    
    //MARK: - Delegate Properties (Undefined)
    var navigateToLogin: (()->())?
    var navigateToVerifyEmail: (()->())?
    var navigateToPersonalityTest: (()->())?
    
    
    func loadData(){
        Task.init {
            do{
                self.profileCardView.data = try await repository?.getUserData(uid: FirebaseAuth.Auth.auth().currentUser?.uid ?? "")
                
            }catch{
                print("ERROR: \(error)")
            }
        }
        
    }
    private func configureUI(){
        
        //ADD SUBVIEWS
        self.view.addSubview(loginButton)
        self.view.addSubview(verifyEmailButton)
        self.view.addSubview(personalityTestButton)
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(recentPostsListContainer)
        self.view.addSubview(testResultContainer)
        self.view.addSubview(profileCardView)
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
        personalityTestButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        loginButton.setTitle("로그인하기", for: .normal)
        loginButton.setTitleColor(.label, for: .normal)
        loginButton.addTarget(self, action: #selector(navigateToLoginView), for: .touchUpInside)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        verifyEmailButton.setTitle("이메일 인증", for: .normal)
        verifyEmailButton.setTitleColor(.label, for: .normal)
        verifyEmailButton.addTarget(self, action: #selector(navigateToVerifyEmailView), for: .touchUpInside)
        
        personalityTestButton.setTitle("성격테스트", for: .normal)
        personalityTestButton.setTitleColor(.label, for: .normal)
        personalityTestButton.addTarget(self, action: #selector(navigateToPersonalityTestView), for: .touchUpInside)
        
        defaultFont = UIFont.systemFont(ofSize: 13)
        
        testResultContainer.backgroundColor = .systemGray5
        testResultTitleLabel.text = "성격테스트 결과"
        testResultTitleLabel.font = UIFont.systemFont(ofSize: 15)
        testResultDetailButton.setTitle("detail", for: .normal)
        testResultDetailButton.setTitleColor(.label, for: .normal)
        testResultDetailButton.tintColor = .label
        testResultDetailButton.addTarget(self, action: #selector(testResultDetailButtonTouchUp), for: .touchUpInside)
        testResultChartView.backgroundColor = .gray
        recentPostsLabel.text = "최근 작성글"
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
            testResultContainer.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.17),
            testResultContainer.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.8 - 20),
            testResultContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            testResultContainer.topAnchor.constraint(equalTo: profileCardView.bottomAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            profileCardView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.2),
            profileCardView.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.8 - 20),
            profileCardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            profileCardView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50)
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
            recentPostsLabel.leadingAnchor.constraint(equalTo: testResultChartView.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            recentPostsNumberLabel.topAnchor.constraint(equalTo: recentPostsLabel.topAnchor),
            recentPostsNumberLabel.leadingAnchor.constraint(equalTo: recentPostsLabel.trailingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            recentPostsListContainer.topAnchor.constraint(equalTo: recentPostsLabel.bottomAnchor, constant: 10),
            recentPostsListContainer.leadingAnchor.constraint(equalTo: testResultChartView.leadingAnchor),
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
            verifyEmailButton.leadingAnchor.constraint(equalTo: bottomButtonGroup.leadingAnchor),
            personalityTestButton.topAnchor.constraint(equalTo: verifyEmailButton.bottomAnchor),
            personalityTestButton.trailingAnchor.constraint(equalTo: verifyEmailButton.trailingAnchor),
            personalityTestButton.leadingAnchor.constraint(equalTo: verifyEmailButton.leadingAnchor),
        ])
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = ProfileViewRepositoryImpl()
        FirebaseAuth.Auth.auth().addStateDidChangeListener({ auth, user in
            if user == nil {
                self.loginButton.isHidden = false
                self.profileCardView.isHidden = true
                self.verifyEmailButton.isHidden = true
                self.personalityTestButton.isHidden = true
                self.testResultContainer.isHidden = true
                self.recentPostsLabel.isHidden = true
                self.recentPostsNumberLabel.isHidden = true
                self.recentPostsListContainer.isHidden = true
                self.recentPostsDetailButton.isHidden = true
                self.bottomButtonGroup.isHidden = true
            }else{
                self.loadData()
                self.loginButton.isHidden = true
                self.profileCardView.isHidden = false
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
                    self.verifyEmailButton.isHidden = true
                }else{
                    self.verifyEmailButton.isHidden = false
                }
                Task.init {
                    let data = try await self.repository?.getUserData(uid: user?.uid ?? "")
                    if data?.personalityTestResult.type == ""{
                        self.verifyEmailButton.isHidden = false
                    }else{
                        self.verifyEmailButton.isHidden = true
                    }
                }
            }
        })
        configureUI()
        setUpLayout()
        
        
        
        self.loginButton.isHidden = false
        self.testResultContainer.isHidden = true
        self.recentPostsLabel.isHidden = true
        self.recentPostsNumberLabel.isHidden = true
        self.recentPostsListContainer.isHidden = true
        self.recentPostsDetailButton.isHidden = true
        self.bottomButtonGroup.isHidden = true
    }
}
