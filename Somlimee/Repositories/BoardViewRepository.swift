//
//  BoardViewRepository.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/22.
//

import Foundation
import FirebaseFirestore

protocol BoardViewRepository{
    func getBoardInfoData(name: String) async throws -> BoardInfoData?
    func getBoardPosts(name: String, start: String) async throws -> [BoardPostMetaData]?
    func writeBoardPost(name: String, post: BoardPostContentData) async throws -> Void
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
    
    
    func getBoardPosts(name: String, start: String) async throws -> [BoardPostMetaData]? {
        guard let dataList = try await DataSourceService.sharedInstance.getBoardPosts(name: name, start: start) else{
            return nil
        }
        var result: [BoardPostMetaData] = []
        for data in dataList{
            
            let boardName: String = name
            
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
    
    func writeBoardPost(name: String, post: BoardPostContentData) async throws {
        do{
            try await DataSourceService.sharedInstance.createPost(name: name, post: post)
        }catch{
            throw DataSourceFailures.CouldNotWritePost
        }
    }
    
    
}
