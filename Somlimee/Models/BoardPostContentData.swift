//
//  BoardPostContentData.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/01.
//

import Foundation
import UIKit

struct BoardPostContentData {
    
    let boardPostMetaData: BoardPostMetaData
    
    let boardPostParagraph: String
    let boardPostImages: [UIImage]
    let boardPostComments: [BoardPostCommentData]
}
