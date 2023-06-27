//
//  PersonalityTestViewRepository.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/04.
//

import Foundation

protocol PersonalityTestViewRepository{
    
    //GET REPOSITORY ITEMS
    func getQuestions() async throws -> PersonalityTestQuestions?
    func updatePersonalityTest(test: PersonalityTestResultData) async throws -> Void
    func getPersonalityTestResult() async throws -> PersonalityTestResultData?
}

final class PersonalityTestViewRepositoryImpl: PersonalityTestViewRepository{
    func getQuestions() async throws -> PersonalityTestQuestions?{
        let rawData = try await DataSourceService.sharedInstance.getQuestions()
        guard let unwrappedRawData = rawData?["questions"] else{
            print("questions rawData empty!")
            return nil
        }
        let castedRawData = unwrappedRawData as? [String]
        guard let unwrappedCastedRawData = castedRawData else {
            print("could not caste rawData")
            return nil
        }
        guard let unwrappedRawData2 = rawData?["category"] else{
            print("questions rawData2 empty!")
            return nil
        }
        let castedRawData2 = unwrappedRawData2 as? [Four]
        guard let unwrappedCastedRawData2 = castedRawData2 else {
            print("could not caste2 rawData")
            return nil
        }
        return PersonalityTestQuestions(questions: unwrappedCastedRawData, category: unwrappedCastedRawData2, answers: [Answer.Neutral])
    }
    func updatePersonalityTest(test: PersonalityTestResultData) async throws -> Void{
        try await DataSourceService.sharedInstance.updatePersonalityTest(test: test)
    }
    func getPersonalityTestResult() async throws -> PersonalityTestResultData? {
        let rawData = try await DataSourceService.sharedInstance.getPersonalityTestResult()
        
        
        guard let unwrappedRawData1 = rawData?["Strenuousness"] else{
            print("fire rawData empty!")
            return nil
        }
        let castedRawData1 = unwrappedRawData1 as? Int
        guard let unwrappedCastedRawData1 = castedRawData1 else {
            print("could not caste rawData")
            return nil
        }
        
        //second
        guard let unwrappedRawData2 = rawData?["Receptiveness"] else{
            print("water rawData empty!")
            return nil
        }
        let castedRawData2 = unwrappedRawData2 as? Int
        guard let unwrappedCastedRawData2 = castedRawData2 else {
            print("could not caste rawData")
            return nil
        }
        guard let unwrappedRawData3 = rawData?["Harmonization"] else{
            print("air rawData empty!")
            return nil
        }
        let castedRawData3 = unwrappedRawData3 as? Int
        guard let unwrappedCastedRawData3 = castedRawData3 else {
            print("could not caste rawData")
            return nil
        }
        guard let unwrappedRawData4 = rawData?["Coagulation"] else{
            print("earth rawData empty!")
            return nil
        }
        let castedRawData4 = unwrappedRawData4 as? Int
        guard let unwrappedCastedRawData4 = castedRawData4 else {
            print("could not caste rawData")
            return nil
        }
        guard let unwrappedRawData5 = rawData?["PersonalityType"] else{
            print("earth rawData empty!")
            return nil
        }
        
        let castedRawData5 = unwrappedRawData5 as? String
        guard let unwrappedCastedRawData5 = castedRawData5 else {
            print("could not caste rawData")
            return nil
        }
        return PersonalityTestResultData(Strenuousness: unwrappedCastedRawData1, Receptiveness: unwrappedCastedRawData2, Harmonization: unwrappedCastedRawData3, Coagulation: unwrappedCastedRawData4, type: unwrappedCastedRawData5)
    }
    
}
