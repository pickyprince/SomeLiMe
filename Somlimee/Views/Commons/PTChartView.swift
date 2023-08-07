//
//  PTChartView.swift
//  Somlimee
//
//  Created by Chanhee on 2023/08/06.
//

import UIKit

class PTChartView: UIView {
    
    var chartData: [Int]? {
        didSet{
            guard let chData = chartData else{
                return
            }
            let biggest = chData.max()!
            NSLayoutConstraint.activate([
                strBar.heightAnchor.constraint(equalTo: self.heightAnchor ,multiplier: (Double(chData[0])/Double(biggest)) - 0.1),
                recBar.heightAnchor.constraint(equalTo: self.heightAnchor ,multiplier: (Double(chData[1])/Double(biggest)) - 0.1),
                harBar.heightAnchor.constraint(equalTo: self.heightAnchor ,multiplier: (Double(chData[2])/Double(biggest)) - 0.1),
                coaBar.heightAnchor.constraint(equalTo: self.heightAnchor ,multiplier: (Double(chData[3])/Double(biggest)) - 0.1),
            ])
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    let backgroundView: UIView = UIView()
    let axisX: UIView = UIView()
    let axisY: UIView = UIView()
    let labelY: UILabel = UILabel()
    
    let barHStack: UIStackView = UIStackView()
    
    let strBar: UIView = UIView()
    let recBar: UIView = UIView()
    let harBar: UIView = UIView()
    let coaBar: UIView = UIView()
    let emptyBar1: UIView = UIView()
    let emptyBar2: UIView = UIView()
    let emptyBar3: UIView = UIView()
    let emptyBar4: UIView = UIView()
    let labelHStack: UIStackView = UIStackView()
    let strLabel: UILabel = UILabel()
    let recLabel: UILabel = UILabel()
    let harLabel: UILabel = UILabel()
    let coaLabel: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //setup
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        axisX.translatesAutoresizingMaskIntoConstraints = false
        axisY.translatesAutoresizingMaskIntoConstraints = false
        labelY.translatesAutoresizingMaskIntoConstraints = false
        barHStack.translatesAutoresizingMaskIntoConstraints = false
        strBar.translatesAutoresizingMaskIntoConstraints = false
        recBar.translatesAutoresizingMaskIntoConstraints = false
        harBar.translatesAutoresizingMaskIntoConstraints = false
        coaBar.translatesAutoresizingMaskIntoConstraints = false
        emptyBar1.translatesAutoresizingMaskIntoConstraints = false
        emptyBar2.translatesAutoresizingMaskIntoConstraints = false
        emptyBar3.translatesAutoresizingMaskIntoConstraints = false
        emptyBar4.translatesAutoresizingMaskIntoConstraints = false
        strLabel.translatesAutoresizingMaskIntoConstraints = false
        recLabel.translatesAutoresizingMaskIntoConstraints = false
        harLabel.translatesAutoresizingMaskIntoConstraints = false
        coaLabel.translatesAutoresizingMaskIntoConstraints = false
        labelHStack.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor(cgColor: SomLimeColors.backgroundColor)
        axisY.backgroundColor = UIColor(cgColor: SomLimeColors.systemGrayLight)
        axisX.backgroundColor = UIColor(cgColor: SomLimeColors.systemGrayLight)
        labelY.textColor = UIColor(cgColor: SomLimeColors.primaryColor)
        labelY.text = "1.0"
        barHStack.axis = .horizontal
        barHStack.distribution = .equalSpacing
        barHStack.alignment = .lastBaseline
        barHStack.spacing = 50
        
        labelHStack.axis = .horizontal
        labelHStack.distribution = .fillEqually
        
        strBar.backgroundColor = UIColor(cgColor: SomLimeColors.primaryColor)
        recBar.backgroundColor = UIColor(cgColor: SomLimeColors.primaryColor)
        harBar.backgroundColor = UIColor(cgColor: SomLimeColors.primaryColor)
        coaBar.backgroundColor = UIColor(cgColor: SomLimeColors.primaryColor)
        
        strLabel.text = "활력성"
        strLabel.font = .hanSansNeoMedium(size: 14)
        strLabel.textAlignment = .center
        recLabel.text = "수용성"
        recLabel.font = .hanSansNeoMedium(size: 14)
        recLabel.textAlignment = .center
        harLabel.text = "조화성"
        harLabel.font = .hanSansNeoMedium(size: 14)
        harLabel.textAlignment = .center
        coaLabel.text = "결집성"
        coaLabel.font = .hanSansNeoMedium(size: 14)
        coaLabel.textAlignment = .center
        self.addSubview(barHStack)
        self.addSubview(labelY)
        self.addSubview(axisX)
        self.addSubview(axisY)
        self.addSubview(labelHStack)
        barHStack.addArrangedSubview(emptyBar1)
        barHStack.addArrangedSubview(strBar)
        barHStack.addArrangedSubview(recBar)
        barHStack.addArrangedSubview(harBar)
        barHStack.addArrangedSubview(coaBar)
        barHStack.addArrangedSubview(emptyBar2)
        
        labelHStack.addArrangedSubview(emptyBar3)
        labelHStack.addArrangedSubview(strLabel)
        labelHStack.addArrangedSubview(recLabel)
        labelHStack.addArrangedSubview(harLabel)
        labelHStack.addArrangedSubview(coaLabel)
        labelHStack.addArrangedSubview(emptyBar4)

        NSLayoutConstraint.activate([
            labelY.topAnchor.constraint(equalTo: topAnchor),
            labelY.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            labelY.heightAnchor.constraint(equalToConstant: 30),
            labelY.widthAnchor.constraint(equalToConstant: 50),
            
            strBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            recBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            harBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            coaBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            emptyBar1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            emptyBar2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            emptyBar3.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05),
            emptyBar4.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05),
            
            barHStack.topAnchor.constraint(equalTo: labelY.bottomAnchor),
            barHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            barHStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            barHStack.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            
            axisY.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            axisY.widthAnchor.constraint(equalToConstant: 3),
            axisY.trailingAnchor.constraint(equalTo: barHStack.leadingAnchor),
            axisY.topAnchor.constraint(equalTo: barHStack.topAnchor),
            
            axisX.topAnchor.constraint(equalTo: barHStack.bottomAnchor),
            axisX.leadingAnchor.constraint(equalTo: axisY.leadingAnchor),
            axisX.widthAnchor.constraint(equalTo: widthAnchor, constant: -70),
            axisX.heightAnchor.constraint(equalToConstant: 3),
            
            labelHStack.topAnchor.constraint(equalTo: axisX.bottomAnchor),
            labelHStack.leadingAnchor.constraint(equalTo: axisY.leadingAnchor),
            labelHStack.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
