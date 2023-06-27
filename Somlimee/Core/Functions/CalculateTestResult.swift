//
//  CalculateTestResult.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/04.
//

import Foundation

func calculateTestResult(test: PersonalityTestQuestions) -> PersonalityTestResultData{
    
    //internal calculation
     var strenuousnessTotal = 0
     var receptivenessTotal = 0
     var harmonizationTotal = 0
     var coagulationTotal = 0
    for answer in test.answers{
        if answer == Answer.Neutral{
            
        }
    }
    return PersonalityTestResultData(Strenuousness: strenuousnessTotal, Receptiveness: receptivenessTotal, Harmonization: harmonizationTotal, Coagulation: coagulationTotal, type: "NDD")
}
