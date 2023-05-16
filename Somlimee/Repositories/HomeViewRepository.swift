//
//  GetOnlyRepository.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/24.
//

import Foundation
import FirebaseFirestore

protocol HomeViewRepository{
    
    //GET REPOSITORY ITEMS
    func getHotTrendData() async throws -> HotTrendData?
    func getHotBoardRankingData() async throws -> HotBaoardRankingData?
    func getCategoryData() async throws -> CategoryData?
    func getBoardListData() async throws -> [String]?
    func getBoardInfoData(name: String) async throws -> BoardInfoData?
    func getBoardPostMetaList(boardName: String, startTime: String) async throws -> [BoardPostMetaData]?
    
}

final class HomeViewRepositoryImpl: HomeViewRepository{
    func getBoardListData() async throws -> [String]? {
        guard let dataList = try await DataSourceService.sharedInstance.getBoardListData()?["list"] as? [String]  else{
            return nil
        }
        return dataList
    }
    func getBoardPostMetaList(boardName: String, startTime: String)async throws -> [BoardPostMetaData]? {
        guard let dataList = try await DataSourceService.sharedInstance.getBoardPostMetaList(boardName: boardName, startTime: startTime) else{
            return nil
        }
        var result: [BoardPostMetaData] = []
        for data in dataList{
            
            let boardName: String = boardName
            
            let postID: String = (data["PostId"] as? String) ?? ""
            let val = (data["PublishedTime"] as? Timestamp)?.dateValue()
            
            let publishedTime: String = String((val?.description as? String)?.prefix(10) ?? "NaN")
            
            let postTypeString: String = (data["PostType"] as? String) ?? ""
            
            let postTitle: String = (data["PostTitle"] as? String) ?? ""
            
            let boardTap: String = (data["BoardTap"] as? String) ?? ""
            
            let userID: String = (data["UserId"] as? String) ?? ""
            
            let numberOfViews: Int = (data["Views"] as? Int) ?? 404
            
            let numberOfVoteUps: Int = (data["VoteUps"] as? Int) ?? 404
            var postType: PostType = PostType.text
            switch postTypeString{
            case "image":
                postType = PostType.image
            case "video":
                postType = PostType.video
            default:
                postType = PostType.text
            }
            result.append(BoardPostMetaData(boardID: boardName, postID: postID, publishedTime: publishedTime, postType: postType, postTitle: postTitle, boardTap: boardTap, userID: userID, numberOfViews: numberOfViews, numberOfVoteUps: numberOfVoteUps))
        }
        
        return result
    }
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
        let data = try await DataSourceService.sharedInstance.getBoardInfoData(boardName: name)
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
