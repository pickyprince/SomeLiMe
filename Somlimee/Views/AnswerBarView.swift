//
//  AnswerBarView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/04.
//

import UIKit
class AnswerBarMarble: UIButton{
    
    
    
    var MarbleSelected: (() -> Void)?
    var onMarbleClicked: (()-> Void)?
    private var isScaled: Bool = false
    
    
    
    
    @objc private func touchUpInide(){
        MarbleSelected?()
        onMarbleClicked?()
    }
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(touchUpInide), for: .touchUpInside)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




class AnswerBarView: UIStackView{
    
    //Declare
    let line: UIView = UIView()
    var lineWidth: CGFloat = 5
    var color: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    internal func reset(){
        for index in 0...(addedMarbles.count-1){
            if addedMarbles[index].frame.width > 15 {
                //shrink
                UIView.animate(withDuration: 0.2, delay: 0, animations: {
                    self.addedMarbles[index].transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }
        }
    }
    var selectedMarble: Int = 0 {
        didSet{
            //Animate Through Marbles: if the marble is the selected marble magnify then continue, the others will shrink if it is magnified
            let ref = addedMarbles[selectedMarble]
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                ref.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
            })
            for index in 0...(addedMarbles.count-1){
                if selectedMarble == index{
                    continue
                }
                
                if addedMarbles[index].frame.width > 8 {
                    //shrink
                    UIView.animate(withDuration: 0.2, delay: 0, animations: {
                        self.addedMarbles[index].transform = CGAffineTransform(scaleX: 1, y: 1)
                    })
                }
            }
        }
    }
    var onMarbleClick: [(()->Void)]? {
        didSet{
            addMarbles()
            for index in 0...(addedMarbles.count-1){
                addedMarbles[index].onMarbleClicked = {
                    self.selectedMarble = index
                }
            }
        }
    }
    var addedMarbles: [AnswerBarMarble] = []
    
    func addMarbles(){
        guard let functions = onMarbleClick else{
            return
        }
        for function in functions{
            let marble = AnswerBarMarble()
            marble.translatesAutoresizingMaskIntoConstraints = false
            marble.MarbleSelected = function
            marble.widthAnchor.constraint(equalToConstant: 15).isActive = true
            marble.heightAnchor.constraint(equalToConstant: 15).isActive = true
            marble.layer.cornerRadius = 7.5
            marble.backgroundColor = color
            addedMarbles.append(marble)
            self.addArrangedSubview(marble)
        }
    }
    
    
    
    
    //Configure
    func configure(){
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.spacing = 30
        
        self.alignment = .center
        line.backgroundColor = color
        line.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    
    
    
    //Layout
    func layout(){
        self.addSubview(line)
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: lineWidth),
            line.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            line.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            line.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
