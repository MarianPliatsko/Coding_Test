import Foundation

class CategoryDataRepository {
    
    enum NetworkError: Error {
        case categoryNotFound
        case timeOut
    }
    
    func getCityList(completion: @escaping (Result<CategoryContainer, NetworkError>) -> Void) {
        let url = URL(string: "https://api-dev.goopter.com/api/v7/hs?city=1&lan=en")
        
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
                        let response = try decoder.decode(CategoryContainer.self, from: data)
                        print(response)
                        DispatchQueue.main.async {
                            completion(.success(response))
                        }
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.categoryNotFound))
                    }
                }
            }
            dataTask.resume()
        }
    }
}
