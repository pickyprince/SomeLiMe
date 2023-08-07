//
//  PersonalityTestResultViewController.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/04.
//

import UIKit

class PersonalityTestResultViewController: UIViewController{
    let chart: PTChartView = PTChartView()
    var testResult: PersonalityTestResultData? {
        didSet{
            guard let data = testResult else {
                return
            }
            chart.chartData = [data.Strenuousness, data.Receptiveness, data.Harmonization, data.Coagulation]
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.addSubview(chart)
        NSLayoutConstraint.activate([
            chart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chart.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            chart.heightAnchor.constraint(equalToConstant: 300),
            chart.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}

