import Foundation
import UIKit

class Settings {
    
    static let shared = Settings()
    
    var loadCount = 100
    let cellID = "cell"
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    let itemsPerRow: CGFloat = 2
    
    let placeHolderImage = UIImage(named: "placeholder-image")
}
