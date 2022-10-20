import Foundation

struct CityContainer: Decodable {
    let records: [CityModel]
}

struct CityModel: Decodable {
    let name: String
}


