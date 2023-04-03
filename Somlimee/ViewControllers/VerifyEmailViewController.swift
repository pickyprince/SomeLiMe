//
//  VerifyEmailViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/03.
//

import UIKit

class VerifyEmailViewController: UIViewController{
    let stackView: UIStackView = UIStackView()
    let textView: UILabel = UILabel()
    let verifyButton: UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        verifyButton.setTitle("이메일 인증하기", for: .normal)
        view.addSubview(stackView)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(verifyButton)
        textView.text = "환영합니다! 당신의 계정이 생성되었습니다.\n이어서 이메일 인증을 진행해주세요.\n이메일 인증을 하지 않을 경우 계정은 3일 뒤에 삭제됩니다."
        textView.numberOfLines = 0
        textView.font = UIFont.systemFont(ofSize: 20)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8)
        ])
        view.backgroundColor = .systemGray3
    }
    
}
