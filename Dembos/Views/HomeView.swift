

import SwiftUI

struct HomeView: View {
    
    @StateObject var HomeModel = HomeViewModel()
    @ObservedObject var authenticationViewModel: AuthViewModel
    @ObservedObject var burgerVM = BurgerVM()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Bienvenido \(authenticationViewModel.user?.email ?? "no user")")
                    .padding(.top, 2)
                
                VStack {
                    VStack{
                        VStack(spacing: 10){
                            HStack(spacing : 15){
                                Button(action: {
                                    withAnimation(.easeIn){
                                        HomeModel.showMenu.toggle()
                                    }
                                }, label: {
                                    Image(systemName: "line.horizontal.3")
                                        .font(.title)
                                        .foregroundColor(Color("pink"))
                                })
                                Text(HomeModel.userLocation == nil ? "Localizando" : "Delivery a..")
                                    .foregroundColor(.black)
                                Text(HomeModel.userAddress)
                                    .font(.caption)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color("pink"))
                                Spacer(minLength: 0)
                            }
                            .padding([.horizontal,.top])
                            Divider()
                            HStack(spacing: 0){
                                TextField("Search", text: $HomeModel.search)
                                if HomeModel.search != ""{
                                    Button(action: {}, label: {
                                        Image(systemName: "magnifyingglass")
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                    })
                                    .animation(.easeIn, value: self.HomeModel)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top,10)
                            
                        }
                        //No Localizacion
                        if HomeModel.noLocation{
                            Text("Por favor activa la localizacion en su configuracion para seguir el proceso de compra!!!")
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                                .background(Color.white)
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.black.opacity(0.3).ignoresSafeArea())
                        }
                        
                        VStack {
                            List(burgerVM.burgers) { burger in
                                HStack(spacing: 15){
                                    
                                    FirebaseStorage(id: burger.image)
                                        .cornerRadius(15)
                                    VStack(alignment: .leading, spacing: 10){
                                        Text(burger.nombre)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                        Text(burger.descripcion)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.gray)
                                        HStack(spacing: 15){
                                            Text(getPrice(value: burger.precio))
                                                .font(.title2)
                                                .fontWeight(.heavy)
                                                .foregroundColor(.black)
                                            Spacer()
                                            Button {
                                                
                                                
                                            } label: {
                                                Image(systemName: "plus")
                                                    .foregroundColor(.blue)
                                                    .padding(10)
                                                    .clipShape(Circle())
                                            }
                                        }
                                    }
                                    
                                }
                                .padding()
                                .background(Color("white"))
                                .contentShape(Rectangle())
                                .offset(x: burger.offset)
                            }
                            
                        }
                        
                        
                        
                    }
                    .onAppear(perform: {
                        //llamando localizacion delegate
                        HomeModel.locationManager.delegate = HomeModel
                        
                        self.burgerVM.getData()
                        
                        //HomeModel.locationManager.requestWhenInUseAuthorization()
                        //modificando Dembos -> info -> Privacy - Location when usage Description
                        
                    })
                    .onChange(of: HomeModel.search, perform: { value in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            
                            if value == HomeModel.search && HomeModel.search != ""{
                                HomeModel.filterData()
                            }
                            
                            if HomeModel.search == ""{
                                withAnimation(.linear){
                                    HomeModel.filtered = HomeModel.items
                                }
                            }
                        }
                    })
                    
                }
                
            }
            
            
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Logout"){
                    authenticationViewModel.logout()
                }
                Spacer()
                HStack {
                    NavigationLink(destination: CartView().navigationBarBackButtonHidden(true) ) {
                        HStack {
                            Image(systemName: "cart")
                            Spacer()
                        }
                    }
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
