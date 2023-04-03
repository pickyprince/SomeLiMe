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
        return nil
    }
    func getCategoryData() async throws -> [String : Any]?{
        return nil
    }
    
    //MARK: - SEARCH VIEW REPOSITORY
}
