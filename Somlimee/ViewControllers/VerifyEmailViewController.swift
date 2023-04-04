//
//  VerifyEmailViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/03.
//

import UIKit
import FirebaseAuth
class VerifyEmailViewController: UIViewController{
    let stackView: UIStackView = UIStackView()
    let textView: UILabel = UILabel()
    let verifyButton: UIButton = UIButton()
    let checkBoxContainerStackView: UIStackView = UIStackView()
    let checkBoxLabel: UILabel = UILabel()
    let checkBox: UIView = UIView()
    let navigationButton: UIButton = UIButton()
    @objc func verifyButtonTouched(){
        print("verify button clicked")
        Task.init {
            do{
                try await UserSignUpWithEmailService.sharedInstance.verifyEmail()
            }catch{
                print("\(error)")
            }
            var counter = 0
            while(!(Auth.auth().currentUser?.isEmailVerified ?? true)){
                print("reloading current user...")
                counter+=1
                sleep(5)
                try? await Auth.auth().currentUser?.reload()
                if(counter > 24) { break }
            }
            print("break")
            if (Auth.auth().currentUser?.isEmailVerified ?? false) {
                self.checkBoxLabel.text = "Email Verified"
                self.checkBoxLabel.textColor = .label
                self.checkBox.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha:1)
                self.navigationButton.isHidden = false
                self.verifyButton.isHidden = true
            }
        }
    }
    @objc func navigateToPT(){
        navigationController?.pushViewController(PersonalityTestViewController(), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener({auth, user in
            print("email verification changed called")
            guard let result = user?.isEmailVerified else{
                return
            }
            if result {
                //verified -> check box and navigate to next vc
                print("email is verified")
                self.checkBoxLabel.text = "Email Verified"
                self.checkBoxLabel.textColor = .label
                self.checkBox.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha:1)
                self.navigationButton.isHidden = false
            }else{
                print("email is not verified")
            }
        })
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        checkBoxLabel.translatesAutoresizingMaskIntoConstraints = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        navigationButton.translatesAutoresizingMaskIntoConstraints = false
        checkBoxContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        checkBoxContainerStackView.axis = .horizontal
        checkBoxContainerStackView.distribution = .fill
        checkBoxContainerStackView.spacing = 10
        checkBoxLabel.text = "Email Not Verified"
        checkBoxLabel.textColor = .red
        checkBox.backgroundColor = .white
        checkBox.layer.borderWidth = 2
        checkBox.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        navigationButton.setTitle("성격테스트 진행", for: .normal)
        navigationButton.setTitleColor(.white, for: .normal)
        navigationButton.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha:1)
        navigationButton.isHidden = true
        navigationButton.addTarget(self, action: #selector(navigateToPT), for: .touchUpInside)
        verifyButton.setTitle("이메일 인증하기", for: .normal)
        verifyButton.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha:1)
        verifyButton.addTarget(self, action: #selector(verifyButtonTouched), for: .touchUpInside)
        
        textView.text = "환영합니다! \n당신의 계정이 생성되었습니다.\n이어서 이메일 인증을 진행해주세요.\n이메일 인증을 하지 않을 경우 계정은 3일 뒤에 삭제됩니다."
        textView.numberOfLines = 0
        textView.font = UIFont.systemFont(ofSize: 20)
        
        view.addSubview(stackView)
        view.addSubview(checkBoxContainerStackView)
        view.addSubview(navigationButton)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(verifyButton)
        checkBoxContainerStackView.addArrangedSubview(checkBoxLabel)
        checkBoxContainerStackView.addArrangedSubview(checkBox)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8)
        ])
        NSLayoutConstraint.activate([
            checkBoxContainerStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            checkBoxContainerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            checkBox.topAnchor.constraint(equalTo: checkBoxLabel.topAnchor),
            checkBox.bottomAnchor.constraint(equalTo: checkBoxLabel.bottomAnchor),
            checkBox.widthAnchor.constraint(equalToConstant: checkBoxLabel.intrinsicContentSize.height)
        ])
        NSLayoutConstraint.activate([
            navigationButton.topAnchor.constraint(equalTo: checkBoxContainerStackView.bottomAnchor, constant: 50),
            navigationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navigationButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8)
        ])
        view.backgroundColor = .systemGray3
    }
    
}
