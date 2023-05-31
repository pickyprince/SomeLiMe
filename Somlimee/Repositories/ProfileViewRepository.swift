//
//  ProfileViewRepository.swift
//  Somlimee
//
//  Created by Chanhee on 2023/05/22.
//

import Foundation

protocol ProfileViewRepository {
    func getUserData(uid: String) async throws -> ProfileData?
}

class ProfileViewRepositoryImpl: ProfileViewRepository{
    func getUserData(uid: String) async throws -> ProfileData? {
        let data = try await DataSourceService.sharedInstance.getUserData(uid: uid)
        guard let userName: String = data?["UserName"] as? String else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        guard let totalUps: Int = data?["TotalUps"] as? Int else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        
        guard let receivedUps: Int = data?["TotalUps"] as? Int else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        
        guard let points: Int = data?["TotalUps"] as? Int else{
            throw DataSourceFailures.CouldNotFindDocument
        }
        
        guard let daysOfActive: Int = data?["TotalUps"] as? Int else{
            throw DataSourceFailures.CouldNotFindDocument
        }
//        guard let personalityTestResult: [String: Any] = data?["PersonalityTestResult"] as? [String: Any] else{
//                throw DataSourceFailures.CouldNotFindDocument
//        }
//        guard let recentPostsNumber: Int = data?["TotalUps"] as? Int else{
//            throw DataSourceFailures.CouldNotFindDocument
//        }
//        guard let recentPostList: [String: Any] = data?["RecentPosts"] as? [String: Any] else{
//                throw DataSourceFailures.CouldNotFindDocument
        return ProfileData(userName: userName, profileImage: nil, totalUps: totalUps, receivedUps: receivedUps, points: points, daysOfActive: daysOfActive, badges: [], personalityTestResult: PersonalityTestResultData(fire: 10, water: 10, air: 10, earth: 10))
    }
}
