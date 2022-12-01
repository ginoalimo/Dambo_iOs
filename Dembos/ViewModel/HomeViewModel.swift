import SwiftUI
import CoreLocation
import Firebase
import simd
//Fetching Usuario localizando..
class HomeViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    //Localizaciones detalles
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    @Published var showMenu = false
   
    @Published var items : [Burger] = []
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Check acceso de localizacion
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            // Llamada directa
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // reading Usuarios localizaciones y extrayendo detalles
       
        self.userLocation = locations.last
        self.extractLocation()
    }
    
    func extractLocation(){
        CLGeocoder().reverseGeocodeLocation(self.userLocation){
            (res, err) in
            guard let safeData = res else{return}
            var address = ""
            
            // getting area y localidad nombre
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
    
    func fechData()
    {
        let db = Firestore.firestore()
        db.collection("Burger").getDocuments { (snap, err) in
            
            guard let itemData = snap else {return}
            
            self.items = itemData.documents.compactMap({(doc) -> Burger? in
                
                let id = doc.documentID
                let nombre = doc.get("nombre") as! String
                let precio = doc.get("precio") as! Float
                let image = doc.get("image") as! String
                let descripcion = doc.get("descripcion") as! String
                
                return Burger(id: id, image: image, nombre: nombre, descripcion: descripcion, precio: precio, quantity: 1, offset: 0, isSwiped: false)
            })
        }
    }
    
}
