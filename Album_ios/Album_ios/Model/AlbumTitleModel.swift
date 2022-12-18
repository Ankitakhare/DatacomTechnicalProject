import Foundation

struct AlbumTitleModel: Codable {
    var userId: Int
    var id: Int
    var title: String
}

struct AlbumUserModel: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}

struct Geo: Codable {
    let lat: String
    let lng: String
}


struct AlbumImageModel: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
