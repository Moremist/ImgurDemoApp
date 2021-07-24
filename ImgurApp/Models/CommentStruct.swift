import Foundation

struct CommentsList: Codable {
    let data: [Comm]
    let success: Bool
    let status: Int
}

struct Comm: Codable {
    let id: Int
    let comment: String
    let author: String

}
