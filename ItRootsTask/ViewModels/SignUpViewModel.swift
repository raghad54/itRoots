//
//  SignUpViewModel.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 03/06/2025.
//

import Foundation

class SignUpViewModel {
    
    var fullName: String = ""
       var username: String = ""
       var password: String = ""
       var email: String = ""
       var phone: String = ""
       var userType: UserType = .user

       var isFullNameValid: Bool { !fullName.trimmingCharacters(in: .whitespaces).isEmpty }
       var isUsernameValid: Bool { !username.isEmpty }
       var isPasswordValid: Bool { password.count >= 6 }
       var isEmailValid: Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
           let pred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return pred.evaluate(with: email)
       }
       var isPhoneValid: Bool {
           let phoneRegEx = "^[0-9]{7,15}$"
           let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
           return pred.evaluate(with: phone)
       }

       func validate() -> Bool {
           return isFullNameValid && isUsernameValid && isPasswordValid && isEmailValid && isPhoneValid
       }
}

