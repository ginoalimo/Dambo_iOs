//
//  RegisterEmailView.swift
//  Dembos
//
//  Created by user231685 on 11/14/22.
//

import SwiftUI

struct RegisterEmailView: View {
    @ObservedObject var authenticationViewModel: AuthViewModel
    @State var emailField: String = ""
    @State var passField: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            DismissView()
                .padding(.top, 8)
            Group {
                Text ("Bienvenido a")
                Text("Dembos")
                    .bold()
                    .underline()
            }
            .padding(.horizontal, 8)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .tint(.primary)
            Group {
                Text("Registrate en nuestra aplicacion")
                    .tint(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 2)
                TextField("Ingrese correo electronico", text: $emailField)
                TextField("Ingrese su contrasena", text: $passField)
                Button("Registrarse") {
                    authenticationViewModel.createNewUser(email: emailField, password: passField)              }
                .padding(.top, 18)
                .buttonStyle(.bordered)
                .tint(.blue)
                
                if let messageError = authenticationViewModel.messageError {
                    Text(messageError)
                        .bold()
                        .font(.body)
                        .foregroundColor(.red)
                        .padding(.top, 20)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 64)
            Spacer()
        }
        
    }
}

struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView(authenticationViewModel: AuthViewModel())
    }
}
