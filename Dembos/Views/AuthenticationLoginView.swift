//
//  EmailLoginView.swift
//  Dembos
//
//  Created by user231685 on 11/13/22.
//

import SwiftUI

enum AuthenticationView: String, Identifiable {
    case register
    case login
    
    var id: String {
        return rawValue
    }
}

struct AuthenticationLoginView: View {
    @State private var authenticationView: AuthenticationView?
    
    var body: some View {
        VStack{
            Image("Login")
                .resizable()
                .frame(width: 200, height: 200)
            
            VStack{
                Button {
                    authenticationView = .login
                } label: {
                    Label("Entra con Email", systemImage: "envelope.fill")
                }
                .tint(.black)
            }
            .controlSize(.large)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top, 60)
            Spacer()
            HStack{
                Button {
                    authenticationView = .register
                } label: {
                    Text("No tienes cuenta?")
                    Text("Registrate")
                        .underline()
                }
                .tint(.black)

            }
        }
        .sheet(item: $authenticationView) { sheet in
            switch sheet {
            case .register:
                Text("Registro")
            case .login:
                Text("Login")
            }
        }
    }
}

struct AuthenticationLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationLoginView()
    }
}
