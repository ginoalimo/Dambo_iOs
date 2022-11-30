import Foundation

struct Burger: Identifiable{
    
    var id: String = UUID().uuidString
    var image: String
    var nombre: String
    var descripcion: String
    var precio: Float
    var quantity: Int
    var offset: CGFloat
    var isSwiped: Bool
    
}
