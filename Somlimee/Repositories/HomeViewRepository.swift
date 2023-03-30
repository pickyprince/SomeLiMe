//
//  GetOnlyRepository.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/24.
//

import Foundation

protocol HomeViewRepository{
        
    //GET REPOSITORY ITEMS
    func getHotTrendData() -> HotTrendData?
    func getBoardHotKeyData() -> BoardHotKeyData?
    func getHotBoardRankingData() -> HotBaoardRankingData?
    func getCategoryData() -> CategoryData?
    
}

final class HomeViewRepositoryImpl{
    
    
}
