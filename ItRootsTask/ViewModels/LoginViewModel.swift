//
//  LoginViewModel.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 03/06/2025.
//

import Foundation

import Foundation

class LoginViewModel {
    var fullName: String = ""
    var username: String = ""
    var password: String = ""
    var email: String = ""
    var phone: String = ""
    var selectedUserType: UserType = .user
    
    private let userDefaultsService = UserDefaultsService()

    var isLoginValid: Bool {
        !username.isEmpty && !password.isEmpty
    }

    func login(completion: @escaping (Bool) -> Void) {
        if isLoginValid {
            let user = User(fullName: nil,
                            username: username,
                            password: password,
                            email: nil,
                            phone: nil,
                            userType: selectedUserType)
            userDefaultsService.saveUser(user)
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func checkAlreadyLoggedIn() -> Bool {
        return userDefaultsService.getUser() != nil
    }
}
