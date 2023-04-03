//
//  UserLoginService.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/31.
//

import Foundation
import Firebase

final class UserLoginService{
    static let sharedInstance = UserLoginService()
    internal func signIn(ID: String, PW: String) async throws -> Void {
        do {
            try await FirebaseAuth.Auth.auth().signIn(withEmail: ID, password: PW)
        } catch{
            throw UserLoginFailures.LoginFailed
        }
    }
    internal func logOut() throws -> Void {
        do {
            try FirebaseAuth.Auth.auth().signOut()
        } catch{
            throw UserLoginFailures.LogOutFailed
        }
    }
}
