//
//  LogInViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/23.
//

import UIKit

class LogInViewController: UIViewController {
    
    //Declare
    let stackView: UIStackView = UIStackView()
    let userID: UITextField = UITextField()
    let userPW: UITextField = UITextField()
    let loginButton: UIButton = UIButton()
    let signUpButton: UIButton = UIButton()
    @objc func loginClicked(){
        let id = self.userID.text ?? ""
        let pw = self.userPW.text ?? ""
        Task.init {
            do{
                print("logging in")
                try await UserLoginService.sharedInstance.signIn(ID: id, PW: pw)
                print("logged in successfully")
                navigationController?.popToRootViewController(animated: true)
            }catch{
                print("not logged in...\(error)")
            }
        }
    }
    @objc func signUpClicked(){
        navigationController?.pushViewController(SignUpViewController(), animated: true)
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
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha:1)
        loginButton.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.setTitle("가입하기", for: .normal)
        signUpButton.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha:1)
        
        signUpButton.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
    }
    
    //Layout
    private func layout(){
        
        userID.translatesAutoresizingMaskIntoConstraints = false
        userPW.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        //add subviews
        view.addSubview(stackView)
        view.addSubview(loginButton)
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
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            loginButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
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
