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
    func getLimeTrendsData() async throws -> LimeTrendsData?
    func getCategoryData() async throws -> CategoryData?
    func getBoardListData() async throws -> [String]?
    func getBoardInfoData(name: String) async throws -> BoardInfoData?
    func getBoardPostMetaList(boardName: String, startTime: String, counts: Int) async throws -> [BoardPostMetaData]?    
    func getUserData(uid: String) async throws -> ProfileData?
    func getBoardHotPostsList(boardName: String, startTime: String, counts: Int) async throws -> [BoardPostMetaData]?
}

final class HomeViewRepositoryImpl: HomeViewRepository{
    func getBoardListData() async throws -> [String]? {
        guard let dataList = try await DataSourceService.sharedInstance.getBoardListData()?["list"] as? [String]  else{
            return nil
        }
        return dataList
    }
    func getBoardPostMetaList(boardName: String, startTime: String, counts: Int) async throws -> [BoardPostMetaData]? {
        guard let dataList = try await DataSourceService.sharedInstance.getBoardPostMetaList(boardName: boardName, startTime: startTime, counts: counts) else{
            return nil
        }
        var result: [BoardPostMetaData] = []
        for data in dataList{
            
            let boardName: String = boardName
            
            let postID: String = (data["PostId"] as? String) ?? ""
            let val = (data["PublishedTime"] as? Timestamp)?.dateValue()
            
            let publishedTime: String = String((val?.description as? String) ?? "NaN")
            
            let postTypeString: String = (data["PostType"] as? String) ?? ""
            
            let postTitle: String = (data["PostTitle"] as? String) ?? ""
            
            let boardTap: String = (data["BoardTap"] as? String) ?? ""
            
            let userID: String = (data["UserId"] as? String) ?? ""
            
            let numberOfViews: Int = (data["Views"] as? Int) ?? 404
            
            let numberOfVoteUps: Int = (data["VoteUps"] as? Int) ?? 404
            
            let numberOfComments: Int = (data["CommentsNumber"] as? Int) ?? 404
            
            var postType: PostType = PostType.text
            switch postTypeString{
            case "image":
                postType = PostType.image
            case "video":
                postType = PostType.video
            default:
                postType = PostType.text
            }
            result.append(BoardPostMetaData(boardID: boardName, postID: postID, publishedTime: publishedTime, postType: postType, postTitle: postTitle, boardTap: boardTap, userID: userID, numberOfViews: numberOfViews, numberOfVoteUps: numberOfVoteUps, numberOfComments: numberOfComments))
        }
        
        return result
    }
    func getBoardHotPostsList(boardName: String, startTime: String, counts: Int) async throws -> [BoardPostMetaData]? {
        guard let list = try await DataSourceService.sharedInstance.getBoardHotPostsList(boardName: boardName, startTime: startTime, counts: counts) else{
            return nil
        }
        var dataList: [[String: Any]] = []
        for id in list {
            guard var data = try await DataSourceService.sharedInstance.getBoardPostMeta(boardName: boardName, postId: id) else{
                continue
            }
            data["PostId"] = id
            dataList.append(data)
        }
        var result: [BoardPostMetaData] = []
        for data in dataList{
            
            let boardName: String = boardName
            
            let postID: String = (data["PostId"] as? String) ?? ""
            let val = (data["PublishedTime"] as? Timestamp)?.dateValue()
            
            let publishedTime: String = String((val?.description as? String) ?? "NaN")
            
            let postTypeString: String = (data["PostType"] as? String) ?? ""
            
            let postTitle: String = (data["PostTitle"] as? String) ?? ""
            
            let boardTap: String = (data["BoardTap"] as? String) ?? ""
            
            let userID: String = (data["UserId"] as? String) ?? ""
            
            let numberOfViews: Int = (data["Views"] as? Int) ?? 404
            
            let numberOfVoteUps: Int = (data["VoteUps"] as? Int) ?? 404
            
            let numberOfComments: Int = (data["CommentsNumber"] as? Int) ?? 404
            
            var postType: PostType = PostType.text
            switch postTypeString{
            case "image":
                postType = PostType.image
            case "video":
                postType = PostType.video
            default:
                postType = PostType.text
            }
            result.append(BoardPostMetaData(boardID: boardName, postID: postID, publishedTime: publishedTime, postType: postType, postTitle: postTitle, boardTap: boardTap, userID: userID, numberOfViews: numberOfViews, numberOfVoteUps: numberOfVoteUps, numberOfComments: numberOfComments))
        }
        
        return result
    }
    func getLimeTrendsData () async throws -> LimeTrendsData? {
        
        let rawData = try await DataSourceService.sharedInstance.getLimeTrendsData()
        guard let unwrappedRawData = rawData?["List"] else{
            print("라임트렌드 없음")
            return nil
        }
        let castedRawData = unwrappedRawData as? [String]
        guard let unwrappedCastedRawData = castedRawData else {
            print("could not cast rawData")
            return nil
        }
        return LimeTrendsData(trendsList: unwrappedCastedRawData)
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
    func getUserData(uid: String) async throws -> ProfileData? {
        let data = try await DataSourceService.sharedInstance.getUserData(uid: uid)
        guard let userName: String = data?["UserName"] as? String else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        guard let totalUps: Int = data?["TotalUps"] as? Int else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        
        guard let receivedUps: Int = data?["TotalUps"] as? Int else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        
        guard let points: Int = data?["TotalUps"] as? Int else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        
        guard let daysOfActive: Int = data?["TotalUps"] as? Int else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        guard let personalityType: String = data?["PersonalityType"] as? String else{
            throw DataSourceFailures.CouldNotFindDocument
        }
//        guard let personalityTestResult: [String: Any] = data?["PersonalityTestResult"] as? [String: Any] else{
//                throw DataSourceFailures.CouldNotFindDocument
//        }
//        guard let recentPostsNumber: Int = data?["TotalUps"] as? Int else{
//            throw DataSourceFailures.CouldNotFindDocument
//        }
//        guard let recentPostList: [String: Any] = data?["RecentPosts"] as? [String: Any] else{
//                throw DataSourceFailures.CouldNotFindDocument
        return ProfileData(userName: userName, profileImage: nil, totalUps: totalUps, receivedUps: receivedUps, points: points, daysOfActive: daysOfActive, badges: [], personalityTestResult: PersonalityTestResultData(Strenuousness: 10, Receptiveness: 10, Harmonization: 10, Coagulation: 10, type: "NDD"), personalityType: personalityType)
    }
    
}
