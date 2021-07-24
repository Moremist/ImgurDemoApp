import Foundation

struct Gallery: Codable{
    var data: [Datum]
}

struct Datum: Codable {
    let id: String
    let title : String
    let images: [Image]?
}

struct Image: Codable {
    let link: String
    let width: Int
    let height: Int
    let type: String
}
