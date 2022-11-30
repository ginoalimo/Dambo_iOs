//
//  CartView.swift
//  Dembos
//
//  Created by user231685 on 11/29/22.
//

import SwiftUI

struct CartView: View {
    @StateObject var carData = BurgerVM()
    var body: some View {
        VStack{
            
            HStack(spacing: 20){
                Button {
                    
                    
                } label: {
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

                        ItemView(item: $carData.burgers[getIndex(item: item)])

                    }
                }
            }
            
        }
        .background(Color("gray").ignoresSafeArea())
        .onAppear(){
            self.carData.getData()
        }
    }
    
    func getIndex(item: Burger) -> Int {
        
        return carData.burgers.firstIndex{ (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
    }
    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
