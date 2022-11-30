

import SwiftUI


class CartViewModel: ObservableObject {
    @ObservedObject var burgerVM = BurgerVM()
    
    @Published var items = []
    
    
    
}
