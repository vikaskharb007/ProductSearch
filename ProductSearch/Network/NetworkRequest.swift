//
//  NetworkRequest.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import Foundation

struct NetworkRequest <T: Decodable> {
    let baseURL: String = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/mobile-assignment"
    var url: String?
    var domain: String
    var searchParameter: String?
    var page: Int?
    
    var searchURLString: String {
        guard let searchParam = searchParameter else {
            return ""
        }
        
        return "?query=\(searchParam)"
    }
    
    var pageURLString: String {
        guard let page = page else {
            return ""
        }
        
        return "&page=\(page)"
    }
    
    init(url: String? = nil, domain: String = "", searchParameter: String? = nil, page: Int? = nil) {
        self.url = url
        self.domain = domain
        self.searchParameter = searchParameter
        self.page = page
    }
    
    // MARK: - Public methods
    func execute(completion: @escaping ((Result<T, NetworkRequestError>) -> Void)) {
        
        let requestURLString = url ?? createURL()
        
        guard let urlString = requestURLString,
              let url = URL(string: urlString)
        else {
            completion(.failure(.genericError("Invalid URL")))
            return
        }
        
        performNetworkRequest(with: url, completion: completion)
    }
}

// MARK: Private methods
extension NetworkRequest {
    private func performNetworkRequest(with url: URL, completion: @escaping ((Result<T, NetworkRequestError>) -> Void)) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let responseData = data else {
                if let error = error {
                    completion(.failure(.apiError(error.localizedDescription)))
                } else {
                    completion(.failure(.genericError("API call failed: Unknown error")))
                }
                
                return
            }
                        
            guard let decodedData = decodeData(input: responseData, withType: T.self) else {
                completion(.failure(.jsonParseError))
                return
            }
            
            completion(.success(decodedData))
        }
        
        task.resume()
    }
    
    private func createURL() -> String? {
        return baseURL + "/\(domain)" + searchURLString + pageURLString
    }
    
    private func decodeData<T: Decodable>(input: Data, withType: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: input)
            return decodedData
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
