//
//  Cart.swift
//  Dembos
//
//  Created by kev28 on 30/11/22.
//

import SwiftUI

struct Cart: Identifiable {
    
    var id = UUID().uuidString
    var item: Burger
    var quantity: Int
    
}
