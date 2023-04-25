//
//  BoardViewRepository.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/22.
//

import Foundation

protocol BoardViewRepository{
    func getBoardInfoData(name: String) async throws -> BoardInfoData?
    func getBoardPosts(name: String) async throws -> [BoardPostMetaData]?
}

class BoardViewRepositoryImpl: BoardViewRepository{
    func getBoardInfoData(name: String) async throws -> BoardInfoData? {
        guard let data = try await DataSourceService.sharedInstance.getBoardInfoData(name: name) else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        
        let boardName: String = name
        
        let boardOwnerID: String = (data["BoardOwnerID"] as? String) ?? ""
        
        let tapList: [String] = (data["BoardTapList"] as? [String]) ?? []
        
        let boardLevel: Int = (data["BoardLevel"] as? Int) ?? 404
        
        let boardDescription: String = (data["BoardDescription"] as? String) ?? ""
        
        let boardHotKeyword: [String] = (data["BoardDescription"] as? [String]) ?? []
        
        return BoardInfoData(boardName: boardName, boardOwnerID: boardOwnerID, tapList: tapList, boardLevel: boardLevel, boardDescription: boardDescription, boardHotKeyword: boardHotKeyword)
    }
    
    func getBoardPosts(name: String) async throws -> [BoardPostMetaData]? {
        return nil
    }
    
    
}
