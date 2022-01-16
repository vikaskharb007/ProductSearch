//
//  NetworkManager.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import Foundation

class NetworkManager: NetworkServicesProtocol {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: - API requests
    
    func searchProducts(searchTerm: String, completion: @escaping ((Result<ProductDetailsResponse, NetworkRequestError>) -> Void))  {
        
        let productDetailsRequest = NetworkRequest<ProductDetailsResponse>(url: nil, domain: "search", searchParameter: searchTerm, page: 1)
        
        productDetailsRequest.execute(completion: completion)
    }

    
    func getImage(url: String, completion: @escaping ((Result<Data, NetworkRequestError>) -> Void)) {
        guard let url = URL(string: url) else {
            completion(.failure(.genericError("Incorrect URL")))
            return
        }
        
        performNetworkRequest(with: url, completion: completion)
    }
    
}

// MARK: - Private Methods
extension NetworkManager {
    
    private func performNetworkRequest(with url: URL, completion: @escaping ((Result<Data, NetworkRequestError>) -> Void)) {
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
            
            completion(.success(responseData))
        }
        
        task.resume()
    }
}
