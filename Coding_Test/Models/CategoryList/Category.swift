import Foundation
import UIKit

struct CategoryContainer: Decodable {
    let records: [CategoryModel]
}

struct CategoryModel: Decodable {
    let categoryId: Int
    let displaySaquence: Int
    let categoryName: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "cid"
        case displaySaquence = "seq"
        case categoryName = "name"
        case imageUrl = "img"
    }
}
