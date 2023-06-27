//
//  BoardFeedData.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/19.
//

import Foundation

enum PostType{
    case image
    case video
    case text
}
struct BoardPostMetaData {
    
    let boardID: String
    
    let postID: String
    
    let publishedTime: String
    
    let postType: PostType
    
    let postTitle: String
    
    let boardTap: String
    
    let userID: String
    
    let numberOfViews: Int
    
    let numberOfVoteUps: Int
    
    let numberOfComments: Int
}
