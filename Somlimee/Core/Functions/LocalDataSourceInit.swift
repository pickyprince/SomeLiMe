//
//  LocalDataSourceInit.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/20.
//

import Foundation

func localDataSourceInit()async throws -> Void{
    try await SQLiteDatabaseCommands.createCategoryTable()
    guard var appStates = try await SQLiteDatabaseCommands.presentAppStatesData() else{
        throw SQLiteDatabaseFailures.CouldNotPresentAppStatesTable
    }
    let isFirstTimeLaunched = appStates["isFirstTimeLaunched"] ?? false
    if isFirstTimeLaunched{
        try await SQLiteDatabaseCommands.insertCategoryRow("First Elem")
        
        try await SQLiteDatabaseCommands.insertCategoryRow("Second Elem")
        
        try await SQLiteDatabaseCommands.insertCategoryRow("Third Elem")
        
        try await SQLiteDatabaseCommands.updateAppStates(appStates: AppStates(isFirstTimeLaunched: false ))
    }else{
        return
    }
    
}
