//
//  PersonalityTestViewRepository.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/04.
//

import Foundation
import FirebaseAuth
protocol PersonalityTestViewRepository{
    
    //GET REPOSITORY ITEMS
    func getQuestions() async throws -> PersonalityTestQuestions?
    func updatePersonalityTest(test: PersonalityTestResultData, uid: String) async throws -> Void
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
    func updatePersonalityTest(test: PersonalityTestResultData, uid: String) async throws -> Void{
        guard var userData = try await DataSourceService.sharedInstance.getUserData(uid: uid) else {
            print(">>>> UPDATE PT - ERROR")
            return
        }
        userData["PersonalityTestResult"] = [test.Strenuousness, test.Receptiveness, test.Harmonization, test.Coagulation]
        userData["PersonalityType"] = test.type
        try await DataSourceService.sharedInstance.updateUser(userInfo: userData)
    }
    func getPersonalityTestResult() async throws -> PersonalityTestResultData? {
        guard var udata = try await DataSourceService.sharedInstance.getUserData(uid: FirebaseAuth.Auth.auth().currentUser?.uid ?? "") else{
            print(">>>> UserDataFailed")
            return nil
        }
        let scores: [Int] = udata["PersonalityTestResult"] as! [Int]
        let type: String = udata["PersonalityType"] as! String
        let str = scores[0]
        let rec = scores[1]
        let har = scores[2]
        let coa = scores[3]
        
        return PersonalityTestResultData(Strenuousness: str, Receptiveness: rec, Harmonization: har, Coagulation: coa, type: type)
    }
    
}
