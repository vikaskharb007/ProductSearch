//
//  MockNetworkManager.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import Foundation

class MockNetworkManager: NetworkServicesProtocol {
    
    static let shared = MockNetworkManager()
    
    private init() {}
    
    func searchProducts(searchTerm: String, completion: @escaping ((Result<ProductDetailsResponse, NetworkRequestError>) -> Void)) {
        if searchTerm == "InvalidSearch" {
            completion(.failure(.jsonParseError))
        }
        
        readFileData(fileName: "ProductSearchResults") { [weak self] isSuccess, fileData in
            guard let data = fileData,
                  isSuccess,
                  let decodedData = self?.decodeData(input: data, withType: ProductDetailsResponse.self)
            else {
                completion(.failure(.jsonParseError))
                return
            }
            
            completion(.success(decodedData))
        }
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

extension MockNetworkManager {
     func readFileData(fileName: String, completion: @escaping (_ isSuccess: Bool, _ parsedCityData: Data?) -> Void) {
        if let path = pathFor(file: fileName) {
            do {
                let filedata = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(true , filedata)
            } catch let error {
                print(error.localizedDescription)
                completion(false , nil)
            }
        } else {
            completion(false , nil)
        }
    }
    
     func pathFor(file: String) -> String? {
        return Bundle.main.path(forResource: file, ofType: "json")
    }
}
