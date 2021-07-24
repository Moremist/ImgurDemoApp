import Foundation

struct Gallery: Codable{
    let data: [Datum]
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
}
