//
//  GetOnlyRepository.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/24.
//

import Foundation

protocol HomeViewRepository{
    
    //GET REPOSITORY ITEMS
    func getHotTrendData() async throws -> HotTrendData?
    func getHotBoardRankingData() async throws -> HotBaoardRankingData?
    func getCategoryData() async throws -> CategoryData?
    func getBoardInfoData(name: String) async throws -> BoardInfoData?
    
}

final class HomeViewRepositoryImpl: HomeViewRepository{
    
    
    func getHotTrendData() async throws -> HotTrendData? {
        
        let rawData = try await DataSourceService.sharedInstance.getHotTrendData()
        guard let unwrappedRawData = rawData?["hotTrendsList"] else{
            print("hotTrendsList rawData empty!")
            return nil
        }
        let castedRawData = unwrappedRawData as? [String]
        guard let unwrappedCastedRawData = castedRawData else {
            print("could not caste rawData")
            return nil
        }
        return HotTrendData(realTimeHotRanking: unwrappedCastedRawData)
    }
    
    func getHotBoardRankingData() async throws -> HotBaoardRankingData? {
        let rawData = try await DataSourceService.sharedInstance.getHotBoardRankingData()
        guard let unwrappedRawData = rawData?["RankingList"] else{
            print("RankingList rawData empty!")
            return nil
        }
        let castedRawData = unwrappedRawData as? [String]
        guard let unwrappedCastedRawData = castedRawData else {
            print("could not caste rawData")
            return nil
        }
        return HotBaoardRankingData(realTimeBoardRanking: unwrappedCastedRawData)
    }
    
    func getCategoryData() async throws -> CategoryData? {
        let data = try await DataSourceService.sharedInstance.getCategoryData()
        let list = (data?["list"] ?? []) as! [String]
        return CategoryData(list: list)
    }
    
    
    
    
    func getBoardInfoData(name: String) async throws -> BoardInfoData? {
        let data = try await DataSourceService.sharedInstance.getBoardInfoData(name: "Vh0eyDgLKArtsRSswXti")
        guard let boardOwnerID = data?["BoardOwnerId"] else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        guard let boardTapList = data?["BoardTapList"]  else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        guard let boardLevel = data?["BoardLevel"] else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        
        guard let boardHotKeyword = data?["BoardHotKeywords"] else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        
        guard let boardDescription = data?["BoardDescription"] else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        return BoardInfoData(boardName: name, boardOwnerID: boardOwnerID as! String, tapList: boardTapList as! [String], boardLevel: boardLevel as! Int, boardDescription: boardDescription as! String, boardHotKeyword: boardHotKeyword as! [String])
    }
}
