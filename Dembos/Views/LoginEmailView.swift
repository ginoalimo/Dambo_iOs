//
//  LoginEmailView.swift
//  Dembos
//
//  Created by user231685 on 11/13/22.
//

import SwiftUI

struct LoginEmailView: View {
    @State var emailField: String = ""
    @State var passField: String = ""
    var body: some View {
        VStack {
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
                TextField("Ingrese su contrasena", text: $passField)
                Button("Login") {
                    print("Login")
                }
                .padding(.top, 18)
                .buttonStyle(.bordered)
                .tint(.blue)
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 64)

        }
    }
}

struct LoginEmailView_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmailView()
    }
}
