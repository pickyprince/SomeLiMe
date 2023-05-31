//
//  LoadingView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/05/31.
//

import UIKit

class LoadingView: UIView {
    
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(loadingIndicator)
        self.backgroundColor = .systemBackground
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.startAnimating()
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: loadingIndicator.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: loadingIndicator.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
