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
    internal func verifyEmail() async throws -> Void{
        //sync
        guard let user = FirebaseAuth.Auth.auth().currentUser else{
            throw UserSignUpFailures.UserDoesNotExist
        }
        if user.isEmailVerified {
            throw UserSignUpFailures.UserAlreadyVerified
        }
        
        //async
        do{
            try await user.sendEmailVerification()
        }catch{
            throw UserSignUpFailures.CouldNotSendVerificationEmail
        }
    }
    
}
