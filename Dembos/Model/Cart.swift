//
//  Cart.swift
//  Dembos
//
//  Created by user231685 on 11/29/22.
//

import Foundation

struct Cart: Identifiable {
    
    var id = UUID().uuidString
    var item: Burger
    var quantity: Int
    
}
