//
//  CacheControlService.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/28.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
final class DataSourceService{
    
    static let sharedInstance = DataSourceService()
    //MARK: - SIGN UP
    func updateUser(userInfo: [String: Any]) async throws -> Void {
        guard let db = RemoteDataSourceService.sharedInstance.database else {
            throw DataSourceFailures.CouldNotFindRemoteDataBase
        }
        guard let user = FirebaseAuth.Auth.auth().currentUser else{
            throw UserLoginFailures.LoginFailed
        }
        let docRef = db.collection("Users").document(user.uid)
        try await docRef.setData(userInfo)
    }
    //MARK: - HOME VIEW REPOSITORY
    
    func getHotTrendData() async throws -> [String : Any]? {
        guard let db = RemoteDataSourceService.sharedInstance.database else {
            throw DataSourceFailures.CouldNotFindRemoteDataBase
        }
        let docRef = db.collection("RealTime").document("RThotTrends")
        let document: DocumentSnapshot
        do {
            document = try await docRef.getDocument()
        }catch{
            print("CouldNotFindDocument")
            throw DataSourceFailures.CouldNotFindDocument
        }
        return document.data()
    }
    
    
    
    func getHotBoardRankingData() async throws -> [String : Any]?{
        guard let db = RemoteDataSourceService.sharedInstance.database else{
            print("CouldNotFindRemoteDataBase")
            throw DataSourceFailures.CouldNotFindRemoteDataBase
        }
        let docRef = db.collection("RealTime").document("RTHotBoardRanking")
        let document: DocumentSnapshot
        do {
            document = try await docRef.getDocument()
        }catch{
            print("CouldNotFindDocument")
            throw DataSourceFailures.CouldNotFindDocument
        }
        return document.data()
    }
    
    
    
    func getCategoryData() async throws -> [String : Any]?{
        do {
            return try await SQLiteDatabaseCommands.presentCategoryRows()
        } catch {
            print("Getting Category Failed: \(error)")
        }
        return nil
    }
    
    func getBoardListData() async throws -> [String: Any]?{
        do {
            return try await SQLiteDatabaseCommands.presentCategoryRows()
        } catch {
            print("Getting Category Failed: \(error)")
        }
        return nil
    }
    //MARK: - PROFILE VIEW REPOSITORY
    func getUserData(uid: String) async throws -> [String: Any]?{
        guard let db = RemoteDataSourceService.sharedInstance.database else{
            print("CouldNotFindRemoteDataBase")
            throw DataSourceFailures.CouldNotFindRemoteDataBase
        }
        guard uid != "" else{
            return nil
        }
        let docRef = db.collection("Users").document(uid)
        let document: DocumentSnapshot
        do {
            document = try await docRef.getDocument()
        }catch{
            print("CouldNotFindDocument")
            throw DataSourceFailures.CouldNotFindDocument
        }
        return document.data()
    }
    //MARK: - SEARCH VIEW REPOSITORY
    
    
    //MARK: - PERSONALITY TEST VIEW REPOSITORY
    func getQuestions() async throws -> [String : Any]?{
        //for only temp
        return [
            "questions": [
                "당신은 활동적입니까?",
                "당신은 종교가 무엇입니까?",
                "당신은 신이 있다고 생각하십니까?",
                "당신은 집에 있기 좋아하십니까?",
                "당신은 집에 있기 좋아하십니까?",
            ],
            "category": [
                Four.Fire,
                Four.Water,
                Four.Water,
                Four.Earth,
                Four.Earth,
            ]
        ]
    }
    func getPersonalityTestResult() async throws -> [String : Any]? {
        //for only temp
        return [
            "Strenousness": 12,
            "Receptiveness": 13,
            "Harmonization": 14,
            "Coagulation": 15,
            "PersonalityType": "ofiejfo",
        ]
    }
    func updatePersonalityTest(test: PersonalityTestResultData) async throws -> Void{
        
    }
    
    
    //MARK: - Board View Repository
    
    func getBoardInfoData(boardName: String) async throws -> [String : Any]?{
        guard let db = RemoteDataSourceService.sharedInstance.database else{
            print(">>>>> CouldNotFindRemoteDataBase")
            throw DataSourceFailures.CouldNotFindRemoteDataBase
        }
        do {
            guard boardName != "" else{
                return nil
            }
            
            let parsedBoardName: String = String(boardName.filter({$0 != "/"}))
            let docRef = db.collection("BoardInfo").document(parsedBoardName)
            let document: DocumentSnapshot
            document = try await docRef.getDocument()
            return document.data()
        }catch{
            print(">>>>>> CouldNotFindDocument")
            throw DataSourceFailures.CouldNotFindDocument
        }
    }
    
    
    func getBoardPostMetaList(boardName: String, startTime: String, counts: Int) async throws -> [[String : Any]]?{
        guard let db = RemoteDataSourceService.sharedInstance.database else{
            print(">>>>> CouldNotFindRemoteDataBase")
            throw DataSourceFailures.CouldNotFindRemoteDataBase
        }
        do {
            var colRef: Query
            
            guard boardName != "" else{
                return nil
            }
            
            guard startTime != "" else{
                return nil
            }
            
            guard counts != 0 else {
                return nil
            }
            let parsedBoardName: String = String(boardName.filter({$0 != "/"}))
            if startTime == "NaN"{
                colRef = db.collection("BoardInfo").document(parsedBoardName).collection("Posts").order(by: "PublishedTime", descending: true).limit(to: counts)
            }else{
                colRef = db.collection("BoardInfo").document(parsedBoardName).collection("Posts").whereField("PublishedTime", isGreaterThanOrEqualTo: startTime).order(by: "PublishedTime", descending: true).limit(to: counts)
            }
            let documents: QuerySnapshot
            documents = try await colRef.getDocuments()
            var data: [[String: Any]] = []
            for document in documents.documents {
                var temp = document.data()
                temp["PostId"] = document.documentID
                data.append(temp)
            }
            return data
        }catch{
            print(">>>>>> CouldNotFindDocument")
            throw DataSourceFailures.CouldNotFindDocument
        }
    }
    
    func getBoardPostMeta(boardName: String, postId: String) async throws -> [String : Any]?{
        guard let db = RemoteDataSourceService.sharedInstance.database else{
            print(">>>>> CouldNotFindRemoteDataBase")
            throw DataSourceFailures.CouldNotFindRemoteDataBase
        }
        
        guard boardName != "" else{
            return nil
        }
        
        let parsedBoardName: String = String(boardName.filter({$0 != "/"}))
        do {
            
            let docRef = db.collection("BoardInfo").document(parsedBoardName).collection("Posts").document(postId)
            return try await docRef.getDocument().data()
        }catch{
            print(">>>>>> CouldNotFindDocument")
            throw DataSourceFailures.CouldNotFindDocument
        }
    }
    func getBoardPostContent(boardName: String, postId: String) async throws -> [[String : Any]]?{
        guard let db = RemoteDataSourceService.sharedInstance.database else{
            print(">>>>> CouldNotFindRemoteDataBase")
            throw DataSourceFailures.CouldNotFindRemoteDataBase
        }
        
        guard boardName != "" else{
            return nil
        }
        
        let parsedBoardName: String = String(boardName.filter({$0 != "/"}))
        guard postId != "" else{
            return nil
        }
        
        do {
            var data: [[String:Any]] = []
            let docRef = db.collection("BoardInfo").document(parsedBoardName).collection("Posts").document(postId).collection("BoardPostContents")
            data.append(try await docRef.document("Paragraph").getDocument().data() ?? [:])
            data.append(try await docRef.document("Image").getDocument().data() ?? [:])
            data.append(try await docRef.document("Video").getDocument().data() ?? [:])
            
            return data
        }catch{
            print(">>>>>> CouldNotFindDocument")
            throw DataSourceFailures.CouldNotFindDocument
        }
    }
    
    func createPost(boardName: String, postData: BoardPostContentData) async throws -> Void{
        
        guard boardName != "" else{
            return
        }
        
        let parsedBoardName: String = String(boardName.filter({$0 != "/"}))
        
        guard let db = RemoteDataSourceService.sharedInstance.database else{
            print(">>>>> CouldNotFindRemoteDataBase")
            throw DataSourceFailures.CouldNotFindRemoteDataBase
        }
        do {
            let colRef = db.collection("BoardInfo").document(parsedBoardName).collection("Posts")
            if postData.boardPostImages.count > 0{
                
                let docRef = colRef.addDocument(data: [
                    "BoardTap":postData.boardPostTap,
                    "CommentsNumber": 0,
                    "PostTitle": postData.boardPostTitle,
                    "PostType": "image",
                    "PublishedTime": FirebaseFirestore.Timestamp(date: Date.now),
                    "ThumbnailURL": "https://eijofieojf/post1.img",
                    "UserId": postData.boardPostUserId,
                    "Views": 0,
                    "VoteUps": 0,
                ])
                try await docRef.collection("BoardPostContents").document("Image").setData([
                    "URLs": ["Not Implemented"]
                ])
                try await docRef.collection("BoardPostContents").document("Paragraph").setData([
                    "Text": postData.boardPostParagraph
                ])
                try await docRef.collection("BoardPostContents").document("Video").setData([
                    "URLs": ["Not Implemented"]
                ])
                
            }else{
                
                let docRef = colRef.addDocument(data: [
                    "BoardTap": postData.boardPostTap,
                    "CommentsNumber": 0,
                    "PostTitle": postData.boardPostTitle,
                    "PostType": "text",
                    "PublishedTime": FirebaseFirestore.Timestamp(date: Date.now),
                    "ThumbnailURL": "https://eijofieojf/post1.img",
                    "UserId": postData.boardPostUserId,
                    "Views": 0,
                    "VoteUps": 0,
                ])
                try await docRef.collection("BoardPostContents").document("Image").setData([
                    "URLs": ["Not Implemented"]
                ])
                try await docRef.collection("BoardPostContents").document("Paragraph").setData([
                    "Text": postData.boardPostParagraph
                ])
                try await docRef.collection("BoardPostContents").document("Video").setData([
                    "URLs": ["Not Implemented"]
                ])
            }
        }catch{
            print(">>>>>> CouldNotFindDocument")
            throw DataSourceFailures.CouldNotFindDocument
        }
    }
    
    
    //MARK: - SEARCH VIEW REPOSITORY
    
    
    //MARK: - COMMON
    
    func updateAppStates(appStates: AppStates) async throws -> Void{
        try await SQLiteDatabaseCommands.updateAppStates(appStates: appStates)
    }
    
    func getAppState()async throws -> [String : Any]?{
        return try await SQLiteDatabaseCommands.presentAppStatesData()
    }
    
}
