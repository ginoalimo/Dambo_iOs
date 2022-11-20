
import SwiftUI

enum AuthenticationView: String, Identifiable {
    case register
    case login
    
    var id: String {
        return rawValue
    }
}

struct AuthenticationLoginView: View {
    @ObservedObject var authenticationViewModel: AuthViewModel
    @State private var authenticationView: AuthenticationView?
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    
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
            Button {
                shouldShowOnboarding.toggle()
            } label: {
                Image(systemName: "power")
                    .foregroundColor(.red)
            }

        }
        .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
            OnboardingView(shouldShowOnboading: $shouldShowOnboarding)
        })
        .sheet(item: $authenticationView) { sheet in
            switch sheet {
            case .register:
                RegisterEmailView(authenticationViewModel: authenticationViewModel)
            case .login:
                LoginEmailView(authenticationViewModel: authenticationViewModel)
            }
        }
    }
}

struct AuthenticationLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationLoginView(authenticationViewModel: AuthViewModel())
    }
}
