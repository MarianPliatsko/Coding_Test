import Foundation

struct BanerContainer: Decodable {
    let records: [BanerModel]
}

struct BanerModel: Decodable {
    let storeId: Int
    let categoryId: Int
    let type: Int
    let imageUrl: String
    let rating: Int
    let city: String
    let width: Int
    let name: String
    let latlon: String
    let hot: Int
    
    
    enum CodingKeys: String, CodingKey {
        case storeId = "id"
        case categoryId = "c_id"
        case type
        case imageUrl = "i_url"
        case rating
        case city
        case width
        case name
        case latlon
        case hot
    }
    var imageFailed: Bool?
}




