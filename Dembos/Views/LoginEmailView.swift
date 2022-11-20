//
//  LoginEmailView.swift
//  Dembos
//
//  Created by user231685 on 11/13/22.
//

import SwiftUI

struct LoginEmailView: View {
    @ObservedObject var authenticationViewModel: AuthViewModel
    @State var emailField: String = ""
    @State var passField: String = ""
    var body: some View {
        VStack {
            DismissView()
                .padding(.top, 8)
            Group {
                Text ("Bienvenido de nuevo a")
                Text("Dembos")
                    .bold()
                    .underline()
            }
            .padding(.horizontal, 8)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .tint(.primary)
            Group {
                Text("Ingrese sus datos")
                    .tint(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 2)
                TextField("Ingrese correo electronico", text: $emailField)
                SecureField("Ingrese su contrasena", text: $passField)
                Button("Login") {
                    authenticationViewModel.login(email: emailField, password: passField)
                }
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

struct LoginEmailView_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmailView(authenticationViewModel: AuthViewModel())
    }
}
