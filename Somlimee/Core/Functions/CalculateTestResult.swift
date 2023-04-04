//
//  CalculateTestResult.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/04.
//

import Foundation

func calculateTestResult(test: PersonalityTestQuestions) -> PersonalityTestResultData{
    
    //internal calculation
     var fireTotal = 0
     var waterTotal = 0
     var airTotal = 0
     var earthTotal = 0
    for answer in test.answers{
        if answer == Answer.Neutral{
            
        }
    }
    return PersonalityTestResultData(fire: fireTotal, water: waterTotal, air: airTotal, earth: earthTotal  )
}
