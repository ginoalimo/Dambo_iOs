import Foundation
import FirebaseFirestore

class BurgerVM: ObservableObject {
    
    @Published var burgers = [Burger]()
    
    private var db = Firestore.firestore()
    
    func getData() {
        db.collection("Burger").addSnapshotListener({ (result, err) in
            guard let documents = result?.documents else {
                return
            }
            self.burgers = documents.map{ (QueryDocumentSnapshot) -> Burger in
                let document = QueryDocumentSnapshot.data()
                let image = document["imagen"] as? String ?? ""
                let nombre = document["nombre"] as? String ?? ""
                let descripcion = document["descripcion"] as? String ?? ""
                let precio = document["precio"] as? Float ?? 0.00
                
                
                
                return Burger(image: image, nombre: nombre, descripcion: descripcion, precio: precio, quantity: 1, offset: 0, isSwiped: false)
                
            }
        })
    }
    
}
