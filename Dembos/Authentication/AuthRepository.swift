//
//  AuthRepository.swift
//  Dembos
//
//  Created by user231685 on 11/14/22.
//

import Foundation

final class AuthRepository {
    private let authenticationFD: AuthenticationFD
    
    init(authenticationFD: AuthenticationFD = AuthenticationFD() ){
        self.authenticationFD = authenticationFD
    }
    
    func getCurrentUser() -> User? {
        authenticationFD.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void) {
        authenticationFD.createNewUser(email: email, password: password, completionBlock: completionBlock)
    }
    
    func login(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void) {
        authenticationFD.login(email: email, password: password, completionBlock: completionBlock)
    }
    
    func logout() throws {
        try authenticationFD.logout()
    }
}
