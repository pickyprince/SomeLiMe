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
    let navigationButton: UIButton = UIButton()
    
    
    let imageView = {
        let imageView = UIImageView(image: UIImage(named: "loginlogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
                self.navigationButton.isHidden = false
            }
        }
    }
    @objc func navigateToPT(){
        navigationController?.pushViewController(PersonalityTestViewController(), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyButtonTouched()
        Auth.auth().addStateDidChangeListener({auth, user in
            print("email verification changed called")
            guard let result = user?.isEmailVerified else{
                return
            }
            if result {
                //verified -> check box and navigate to next vc
                print("email is verified")
                self.checkBoxLabel.text = "이메일 인증 완료"
                self.checkBoxLabel.textColor = .label
                self.navigationButton.isHidden = false
            }else{
                print("email is not verified")
            }
        })
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        checkBoxLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationButton.translatesAutoresizingMaskIntoConstraints = false
        
        checkBoxLabel.text = "이메일 인증 미완료"
        checkBoxLabel.textColor = .red
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        navigationButton.setTitle("성격테스트 진행", for: .normal)
        navigationButton.setTitleColor(.white, for: .normal)
        navigationButton.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha:1)
        navigationButton.isHidden = true
        navigationButton.addTarget(self, action: #selector(navigateToPT), for: .touchUpInside)
        verifyButton.setTitle("이메일 인증 메일 새로 보내기", for: .normal)
        verifyButton.backgroundColor = UIColor(cgColor: SomLimeColors.primaryColor)
        verifyButton.setTitleColor(UIColor(cgColor: SomLimeColors.label), for: .normal)
        verifyButton.addTarget(self, action: #selector(verifyButtonTouched), for: .touchUpInside)
        textView.text = "이메일 인증을 완료해야 활동이 가능합니다.\n인증 완료하지 않을 시에 5일 후에 계정이\n삭제됩니다."
        textView.numberOfLines = 0
        textView.font = UIFont.systemFont(ofSize: 20)
        checkBoxContainerStackView.axis = .horizontal
        checkBoxContainerStackView.distribution = .equalCentering
        view.addSubview(stackView)
        view.addSubview(checkBoxContainerStackView)
        view.addSubview(navigationButton)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(verifyButton)
        checkBoxContainerStackView.addArrangedSubview(checkBoxLabel)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8)
        ])
        NSLayoutConstraint.activate([
            checkBoxContainerStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            checkBoxContainerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            navigationButton.topAnchor.constraint(equalTo: checkBoxContainerStackView.bottomAnchor, constant: 50),
            navigationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navigationButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8)
        ])
        view.backgroundColor = .systemGray3
    }
    
}
