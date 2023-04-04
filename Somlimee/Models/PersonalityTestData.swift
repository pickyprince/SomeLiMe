//
//  PersonalityTestData.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/28.
//

import Foundation
enum Answer {
    case StronglyDisagree
    case Disagree
    case Neutral
    case Agree
    case StronglyAgree
}
enum Four {
    case Fire
    case Water
    case Air
    case Earth
}
struct PersonalityTestQuestions{
    let questions: [String]
    let category: [Four]
    var answers: [Answer]
}
