

import SwiftUI

struct HomeView: View {
    @ObservedObject var authenticationViewModel: AuthViewModel
    @ObservedObject var burgerVM = BurgerVM()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Bienvenido \(authenticationViewModel.user?.email ?? "no user")")
                    .padding(.top, 2)
                List(burgerVM.burgers){
                    burger in
                    HStack{
                        FirebaseStorage(id: burger.image)
                        VStack(alignment: .leading){
                            Text(burger.nombre).font(.title)
                            Text(burger.descripcion).font(.subheadline)
                            Text(String(burger.precio)).font(.headline)

                        }.padding(.leading)
                        
                        Spacer(minLength: 1)
                        
                        Button {
                            //Codigo de lo que hace el boton.
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                                .padding(10)
                                .background(Color("pink"))
                                .clipShape(Circle())
                        }
                    }
                }
                .onAppear(){
                    self.burgerVM.getData()
                }
                
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
