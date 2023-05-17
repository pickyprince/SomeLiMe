//
//  BoardViewRepository.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/22.
//

import Foundation
import FirebaseFirestore

protocol BoardViewRepository{
    func getBoardInfoData(boardName: String) async throws -> BoardInfoData?
    func getBoardPostMetaList(boardName: String, startTime: String) async throws -> [BoardPostMetaData]?
    func writeBoardPost(boardName: String, postData: BoardPostContentData) async throws -> Void
    func getBoardPostMeta(boardName: String, postId: String) async throws -> BoardPostMetaData?
    func getBoardPostContent(boardName: String, postId: String) async throws -> BoardPostContentData?
}

class BoardViewRepositoryImpl: BoardViewRepository{
    
    
    func getBoardInfoData(boardName: String) async throws -> BoardInfoData? {
        guard let data = try await DataSourceService.sharedInstance.getBoardInfoData(boardName: boardName) else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        
        let boardName: String = boardName
        
        let boardOwnerID: String = (data["BoardOwnerID"] as? String) ?? ""
        
        let tapList: [String] = (data["BoardTapList"] as? [String]) ?? []
        
        let boardLevel: Int = (data["BoardLevel"] as? Int) ?? 404
        
        let boardDescription: String = (data["BoardDescription"] as? String) ?? ""
        
        let boardHotKeyword: [String] = (data["BoardDescription"] as? [String]) ?? []
        
        return BoardInfoData(boardName: boardName, boardOwnerID: boardOwnerID, tapList: tapList, boardLevel: boardLevel, boardDescription: boardDescription, boardHotKeyword: boardHotKeyword)
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
    
    func writeBoardPost(boardName: String, postData: BoardPostContentData) async throws -> Void {
        do{
            try await DataSourceService.sharedInstance.createPost(boardName: boardName, postData: postData)
        }catch{
            throw DataSourceFailures.CouldNotWritePost
        }
    }
    
    func getBoardPostMeta(boardName: String, postId: String) async throws -> BoardPostMetaData? {
        guard let data = try await DataSourceService.sharedInstance.getBoardPostMeta(boardName: boardName, postId: postId) else{
            return nil
        }
        let boardName: String = boardName
        
        let postID: String = (data["PostId"] as? String) ?? ""
        let val = (data["PublishedTime"] as? Timestamp)?.dateValue()
        
        let publishedTime: String = String((val?.description as? String)?.prefix(16) ?? "NaN")
        
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
        return BoardPostMetaData(boardID: boardName, postID: postID, publishedTime: publishedTime, postType: postType, postTitle: postTitle, boardTap: boardTap, userID: userID, numberOfViews: numberOfViews, numberOfVoteUps: numberOfVoteUps)
        
        
    }
    func getBoardPostContent(boardName: String, postId: String) async throws -> BoardPostContentData? {
        guard let data = try await DataSourceService.sharedInstance.getBoardPostContent(boardName: boardName, postId: postId) else{
            return nil
        }
        
        guard let meta = try await DataSourceService.sharedInstance.getBoardPostMeta(boardName: boardName, postId: postId) else{
            return nil
        }
        let urls: [String] = (data[1]["URLs"] as? [String]) ?? []
        let boardPostTap = (meta["BoardTap"] as? String) ?? ""
        let boardPostUserId = (meta["userId"] as? String) ?? ""
        let boardPostTitle = (meta["PostTitle"] as? String) ?? ""
        print(">>>> \(data[0])")
        let boardPostParagraph = (data[0]["Text"] as? String) ?? ""
        return BoardPostContentData(boardPostTap: boardPostTap, boardPostUserId: boardPostUserId, boardPostTitle: boardPostTitle, boardPostParagraph: boardPostParagraph, boardPostImages: [])
    }
    
    
}
