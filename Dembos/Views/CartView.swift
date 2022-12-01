//
//  CartView.swift
//  Dembos
//
//  Created by user231685 on 11/29/22.
//

import SwiftUI
import simd

struct CartView: View {
    @StateObject var carData = BurgerVM()
    @Environment(\.presentationMode) var present
    var body: some View {
        VStack{
            
            HStack(spacing: 20){
                Button(action: {present.wrappedValue.dismiss()}) {
                
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(.black)
                }
                
                Text("Carrito")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false){
                
                LazyVStack(spacing: 0){
                    
                    ForEach(carData.burgers){ item in

                        ItemView(item: $carData.burgers[getIndex(item: item)], items: $carData.burgers)

                    }
                }
            }
            
            VStack{
                HStack{
                    Text("Total")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    //calculando el precio total
                    Text(calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }.padding([.top,.horizontal])
                
                Button(action: {}) {
                    Text("Check out")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(
                            LinearGradient(gradient: .init(colors:[Color("lightblue"),Color("blue")]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(15)
                }
            }
            .background(Color.white)
        }
        .background(Color("white").ignoresSafeArea())
        .onAppear(){
            self.carData.getData()
        }
    }
    
    func getIndex(item: Burger) -> Int {
        
        return carData.burgers.firstIndex{ (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
    }
    
    func calculateTotalPrice()->String{
        var precio: Float = 0
        
        carData.burgers.forEach{ (item) in
            precio += Float(item.quantity) * item.precio
      }
        return getPrice(value: precio)
    }
    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
