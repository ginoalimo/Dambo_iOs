import Foundation
import SwiftUI

let placeholder = UIImage(named: "loader.png")!
struct FirebaseStorage : View {
        
    init(id: String) {
        self.imageLoader = Loader(id)
    }

    @ObservedObject private var imageLoader : Loader

    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }

    var body: some View {
        Image(uiImage: image ?? placeholder).resizable().frame(width: 54, height: 54, alignment: .leading)

    }
}
