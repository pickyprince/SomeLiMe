//
//  UserLoginService.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/31.
//

import Foundation
import Firebase

class UserLoginService{
    static let sharedInstance = UserLoginService()
    internal var isUserLoggedIn: Bool = false
    private init(){
        FirebaseAuth.Auth.auth().addStateDidChangeListener({ auth, user in
            if user == nil{
                self.isUserLoggedIn = false
            }else{
                self.isUserLoggedIn = true
            }
        })
    }
}
