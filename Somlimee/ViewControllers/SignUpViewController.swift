//
//  SignUpViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/03.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //Declare
    let stackView: UIStackView = UIStackView()
    let userID: UITextField = UITextField()
    let userPW: UITextField = UITextField()
    let signUpButton: UIButton = UIButton()
    
    @objc func signUpClicked(){
        let id = self.userID.text ?? ""
        let pw = self.userPW.text ?? ""
        Task.init {
            do{
                print("Creating User")
                try await UserSignUpWithEmailService.sharedInstance.createUser(Email: id, PW: pw, userInfo: ProfileData(userName: "안녕하세용", profileImage: nil, totalUps: 0, receivedUps: 0, points: 0, daysOfActive: 0, badges: [], personalityTestResult: PersonalityTestResultData(fire: 10, water: 10, air: 10, earth: 10), recentPostsNumber: 0, recentPostList: nil))
                print("Created User Successfully")
                navigationController?.pushViewController(VerifyEmailViewController(), animated: true)
            }catch UserSignUpFailures.CouldNotCreatUser{
                print(">>>>ERROR: Could Not Creat User")
            }
        }
    }
    //Configure
    private func configure(){
        view.backgroundColor = .systemBackground
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        userID.layer.cornerRadius = 20
        userPW.layer.cornerRadius = 20
        userID.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha:0.2)
        userPW.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha:0.2)
        userID.placeholder = "아이디..."
        userPW.placeholder = "패스워드..."
        signUpButton.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.setTitle("가입하기", for: .normal)
        signUpButton.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha:1)
    }
    
    //Layout
    private func layout(){
        
        userID.translatesAutoresizingMaskIntoConstraints = false
        userPW.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        //add subviews
        view.addSubview(stackView)
        view.addSubview(signUpButton)
        stackView.addArrangedSubview(userID)
        stackView.addArrangedSubview(userPW)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            signUpButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
    }
    override func viewDidLoad() {
        configure()
        layout()
        super.viewDidLoad()
    }

}
