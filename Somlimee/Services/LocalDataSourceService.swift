//
//  LocalDataSourceService.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/28.
//

import Foundation
import SQLite


class LocalDatabaseService{
    static let sharedInstance = LocalDatabaseService()
    var database: Connection?
    
    private init(){
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appending(path:"Somlimee").appendingPathExtension("sqlite3")
            database = try Connection(fileUrl.path)
            
        } catch{
            print("Error: database connection failed!")
        }
    }
}
