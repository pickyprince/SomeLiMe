//
//  AppStatesInit.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/20.
//

import Foundation

func appStatesInit()async throws -> Void{
    try await SQLiteDatabaseCommands.createAppStatesTable()
    
    let result = try await SQLiteDatabaseCommands.presentAppStatesData()
    if result == nil {
        return
    }else{
        if result?["isFirstTimeLaunched"] == false {
            return
        }
    }
    try await SQLiteDatabaseCommands.insertAppStatesRow(name: "isFirstTimeLaunched", bool: true)
}
