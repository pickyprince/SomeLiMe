//
//  LocalDataSourceService.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/28.
//

import Foundation
import SQLite


final class LocalDataSourceService{
    static let sharedInstance = LocalDataSourceService()
    var database: Connection?
    
    private init(){
        //initial setup
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appending(path:"Somlimee").appendingPathExtension("sqlite3")
            database = try Connection(fileUrl.path)
            try database?.run(SQLQueryCollections.createCategoryTable)
        } catch{
            database = nil
        }
    }
}
