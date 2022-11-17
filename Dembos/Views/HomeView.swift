

import SwiftUI

struct HomeView: View {
    @ObservedObject var authenticationViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Bienvenido \(authenticationViewModel.user?.email ?? "no user")")
                    .padding(.top, 32)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Logout"){
                    authenticationViewModel.logout()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(authenticationViewModel: AuthViewModel())
    }
}
