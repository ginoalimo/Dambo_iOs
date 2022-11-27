import Foundation
import FirebaseFirestore

class BurgerVM: ObservableObject {
    var number: Int = 1
    @Published var burgers = [Burger]()
    
    private var db = Firestore.firestore()
    
    func getData() {
        db.collection("Burger").addSnapshotListener({ (result, err) in
            guard let documents = result?.documents else {
                return
            }
            self.burgers = documents.map{ (QueryDocumentSnapshot) -> Burger in
                let document = QueryDocumentSnapshot.data()
                let image = "b\(self.number).png"
                let nombre = document["nombre"] as? String ?? ""
                let descripcion = document["descripcion"] as? String ?? ""
                let precio = document["precio"] as? String ?? ""
                
                self.number += 1
                
                return Burger(image: image, nombre: nombre, descripcion: descripcion, precio: precio)
                
            }
        })
    }
    
}
