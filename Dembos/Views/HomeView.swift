

import SwiftUI

struct HomeView: View {
    @Binding var item: Burger
    @StateObject var HomeModel = HomeViewModel()
    @ObservedObject var authenticationViewModel: AuthViewModel
    @ObservedObject var burgerVM = BurgerVM()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Bienvenido \(authenticationViewModel.user?.email ?? "no user")")
                    .padding(.top, 2)
                
                VStack {
                    HStack(spacing: 15){
                        FirebaseStorage(id: item.image)
                            .cornerRadius(15)
                        VStack(alignment: .leading, spacing: 10){
                            Text(item.nombre)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(item.descripcion)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            HStack(spacing: 15){
                                Text(getPrice(value:item.precio))
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                Spacer(minLength: 0)
                                Button ( action:{
                                    if item.quantity > 1{
                                        item.quantity -= 1
                                    }
                                }){
                                    Image(systemName: "minus")
                                        .font(.system(size: 16, weight: .heavy))
                                        .foregroundColor(.black)
                                }
                                Text("\(item.quantity)")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.black.opacity(0.06))
                                Button (action: {item.quantity += 1})
                                {
                                    Image(systemName: "plus")
                                        .font(.system(size: 16, weight: .heavy))
                                        .foregroundColor(.black)
                                }

                            }
                        }
                            
                    }
                    .padding()
                    .background(Color("white"))
                    .contentShape(Rectangle())
                    .offset(x: item.offset)
                    
                                NavigationLink(destination: CartView()) {
                                    Text("Click para ir a CartView")
                                }
               
                    ZStack{
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
                            HStack(spacing: 15){
                                TextField("Search", text: $HomeModel.search)
                                //Slide Menu para el carrito
                                if HomeModel.search != ""{
                                    Button(action: {}, label: {
                                        Image(systemName: "magnifyingglass")
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                    })
                                    .animation(.easeIn)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top,10)
                            Divider()
                            Spacer()
                        }
                        HStack{
                            Menu(homeData: HomeModel)
                            //Move Effect from left
                                .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                            Spacer(minLength: 0)
                        }
                        .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                            .onTapGesture(perform: {
                                withAnimation(.easeIn){
                                    HomeModel.showMenu.toggle()
                                }
                            })
                        )
                        
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
                    }
                    .onAppear(perform: {
                        //llamando localizacion delegate
                        HomeModel.locationManager.delegate = HomeModel
                        //HomeModel.locationManager.requestWhenInUseAuthorization()
                        //modificando Dembos -> info -> Privacy - Location when usage Description
                        
                    })
               
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



