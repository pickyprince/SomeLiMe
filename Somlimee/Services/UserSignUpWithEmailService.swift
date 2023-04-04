//
//  UserSignUpWithEmailService.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/31.
//

import Foundation
import Firebase


final class UserSignUpWithEmailService{
    static let sharedInstance = UserSignUpWithEmailService()
    internal func createUser(Email: String, PW: String) async throws -> Void{
        do{
            try await FirebaseAuth.Auth.auth().createUser(withEmail: Email, password: PW)
        }catch{
            print("CouldNotCreatUser")
            throw UserSignUpFailures.CouldNotCreatUser
        }
    }
    internal func verifyEmail() async throws -> Void{
        
        guard let user = FirebaseAuth.Auth.auth().currentUser else{
                print("UserDoesNotExist")
            throw UserSignUpFailures.UserDoesNotExist
        }
        if user.isEmailVerified {
            print("UserAlreadyVerifiedError")
            throw UserSignUpFailures.UserAlreadyVerified
        }
        
        do{
            try await user.sendEmailVerification()
        }catch{
                print("CouldNotSendVerificationEmail")
            throw UserSignUpFailures.CouldNotSendVerificationEmail
        }
    }
    
}
