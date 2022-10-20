import Foundation

final class CityDataRepository {
    
    static let shared = CityDataRepository()

    enum NetworkError: Error {
        case cityNotFound
        case timeOut
    }

    func getCityList(completion: @escaping (Result<CityContainer, NetworkError>) -> Void) {
        let url = URL(string: "https://api-dev.goopter.com/api/v7/city?lan=en&cntry=1")

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
                        let response = try decoder.decode(CityContainer.self, from: data)
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
