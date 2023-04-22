//
//  LocalDataSourceInit.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/20.
//

import Foundation

func localDataSourceInit()async throws -> Void{
    try await SQLiteDatabaseCommands.createCategoryTable()
    guard let appStates = try await SQLiteDatabaseCommands.presentAppStatesData() else{
        throw SQLiteDatabaseFailures.CouldNotPresentAppStatesTable
    }
    let isFirstTimeLaunched = appStates["isFirstTimeLaunched"] ?? false
    if isFirstTimeLaunched{
        try await SQLiteDatabaseCommands.insertCategoryRow("유머")
        
        try await SQLiteDatabaseCommands.insertCategoryRow("스포츠")
        
        try await SQLiteDatabaseCommands.insertCategoryRow("정치")
        
        try await SQLiteDatabaseCommands.updateAppStates(appStates: AppStates(isFirstTimeLaunched: false ))
    }else{
        return
    }
    
}
