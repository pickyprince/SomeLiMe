//
//  CacheControlService.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/28.
//

import Foundation
import FirebaseFirestore

final class DataSourceService{
    static let sharedInstance = DataSourceService()
    
    
    //MARK: - HOME VIEW REPOSITORY
    func getHotTrendData() async throws -> [String : Any]? {
        guard let db = RemoteDataSourceService.sharedInstance.database else{
            print("CouldNotFindRemoteDataBase")
            throw DataSourceFailures.CouldNotFindRemoteDataBase
        }
        let docRef = db.collection("RealTime").document("RThotTrends")
        let document: DocumentSnapshot
        do {
            document = try await docRef.getDocument()
        }catch{
            print("CouldNotFindDocument")
            throw DataSourceFailures.CouldNotFindDocument
        }
        return document.data()
    }
    func getBoardHotKeyData() async throws -> [String : Any]?{
        return nil
    }
    func getHotBoardRankingData() async throws -> [String : Any]?{
        guard let db = RemoteDataSourceService.sharedInstance.database else{
            print("CouldNotFindRemoteDataBase")
            throw DataSourceFailures.CouldNotFindRemoteDataBase
        }
        let docRef = db.collection("RealTime").document("RTHotBoardRanking")
        let document: DocumentSnapshot
        do {
            document = try await docRef.getDocument()
        }catch{
            print("CouldNotFindDocument")
            throw DataSourceFailures.CouldNotFindDocument
        }
        return document.data()
    }
    func getCategoryData() async throws -> [String : Any]?{
        return nil
    }
    
    //MARK: - SEARCH VIEW REPOSITORY
    
    
    //MARK: - PERSONALITY TEST VIEW REPOSITORY
    func getQuestions() async throws -> [String : Any]?{
        //for only temp
        return [
            "questions": [
                "당신은 활동적입니까?",
                "당신은 종교가 무엇입니까?",
                "당신은 신이 있다고 생각하십니까?",
                "당신은 집에 있기 좋아하십니까?",
                "당신은 집에 있기 좋아하십니까?",
            ],
            "category": [
                Four.Fire,
                Four.Water,
                Four.Water,
                Four.Earth,
                Four.Earth,
            ]
        ]
    }
    func getPersonalityTestResult() async throws -> [String : Any]? {
        //for only temp
        return [
            "fire": 12,
            "water": 13,
            "air": 14,
            "earth": 15
        ]
    }
    func updatePersonalityTest(test: PersonalityTestResultData) async throws -> Void{
        
    }
}
