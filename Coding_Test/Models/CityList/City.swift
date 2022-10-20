//
//  CityList.swift
//  Coding_Test
//
//  Created by mac on 2022-10-13.
//

import Foundation

struct CityContainer: Decodable {
    let records: [CityModel]
}

struct CityModel: Decodable {
    let name: String
}


