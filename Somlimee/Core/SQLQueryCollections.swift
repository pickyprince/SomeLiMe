//
//  SQLQueryCollections.swift
//  Somlimee
//
//  Created by Chanhee on 2023/04/01.
//

import Foundation
import SQLite
class SQLQueryCollections{
    static var categoryTable = Table("Category")
    
    //Expressions
    static let CategoryName = Expression<String>("CategoryName")
    
    //Ceate CategoryTable
    static func createTable(){
        guard let database = LocalDataSourceService.sharedInstance.database else{
            print("dataconnectionfailed!")
            return
        }
        do{
            try database.run(categoryTable.create(ifNotExists: true){ table in
                table.column(CategoryName)
            })
        }catch{
            print("Table already exist: \(error)")
        }
    }
    
}
