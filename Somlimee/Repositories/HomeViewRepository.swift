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
    func getBoardHotKeyData() async throws -> BoardHotKeyData?
    func getHotBoardRankingData() async throws -> HotBaoardRankingData?
    func getCategoryData() async throws -> CategoryData?
    
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
    
    
    func getBoardHotKeyData() async throws -> BoardHotKeyData? {
        return nil
    }
}
