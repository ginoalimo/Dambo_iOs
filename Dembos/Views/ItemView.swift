//
//  ItemView.swift
//  Dembos
//
//  Created by user231685 on 11/29/22.
//

import SwiftUI

struct ItemView: View {
    @Binding var item: Burger
    var body: some View {
        
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
                    
                    Text(String(item.precio))
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
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
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.black)
                    }

                }
            }
                
        }
        .padding()
    }
}



