//
//  RemoteDataSourceService.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/28.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


final class RemoteDataSourceService{
    static let sharedInstance = RemoteDataSourceService()
    var database: Firestore?
    init(){
        database = Firestore.firestore()
    }
}
