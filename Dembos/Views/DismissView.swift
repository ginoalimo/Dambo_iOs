//
//  DismissView.swift
//  Dembos
//
//  Created by user231685 on 11/14/22.
//

import SwiftUI

struct DismissView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack() {
            HStack(alignment: .top){
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Cerrar")
                        .tint(.black)
                        .padding(.trailing, 12)
                }.buttonStyle(.bordered)
                
            }
            
        }
        
    }
}

struct DismissView_Previews: PreviewProvider {
    static var previews: some View {
        DismissView()
    }
}
