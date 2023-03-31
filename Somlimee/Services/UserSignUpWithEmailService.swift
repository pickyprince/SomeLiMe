//
//  UserSignUpWithEmailService.swift
//  Somlimee
//
//  Created by Chanhee on 2023/03/31.
//

import Foundation
import Firebase

class UserSignUpWithEmailService{
    static let sharedInstance = UserSignUpWithEmailService()
    internal func verifyEmail() -> Result<Int, B>{
        guard let user = FirebaseAuth.Auth.auth().currentUser else{
            return
        }
        if user.isEmailVerified {
            return
        }else{
            user.sendEmailVerification(){ _ in
                return
            }
        }
    }
}
