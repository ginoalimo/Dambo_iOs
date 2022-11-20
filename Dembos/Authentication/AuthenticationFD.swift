

import Foundation
import FirebaseAuth

struct User {
    let email: String
}

final class AuthenticationFD {
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        return .init(email: email)
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {
            authDataResult, error in
            if let error = error {
                print("Error creando un nuevo usuario \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No hay ningun email"
            print("Nuevo usuario creado \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {
            authDataResult, error in
            if let error = error {
                print("Error ingresando \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No hay ningun email"
            print("Usuario ingresado \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}
