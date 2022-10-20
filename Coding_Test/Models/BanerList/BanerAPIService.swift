//
//  BanerAPIService.swift
//  Coding_Test
//
//  Created by mac on 2022-10-15.
//

import Foundation

final class BanerDataRepository {
    
    static let shared = BanerDataRepository()

    enum NetworkError: Error {
        case cityNotFound
        case timeOut
    }

    func getBaner(completion: @escaping (Result<BanerContainer, NetworkError>) -> Void) {
        let url = URL(string: "https://api-dev.goopter.com/api/v7/hlst?latlon=49.213366,-122.988651&lan=en&page=1&limit=20&city=1&c_id=1")

        if let url = url {

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil || data == nil {
                    return
                }
                do {
                    let decoder = JSONDecoder()

                    if let data = data {
                        let response = try decoder.decode(BanerContainer.self, from: data)
                        print(response)
                        DispatchQueue.main.async {
                            completion(.success(response))
                        }
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.cityNotFound))
                    }
                }
            }
            dataTask.resume()
        }
    }
}
