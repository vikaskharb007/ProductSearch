//
//  NetworkServicesProtocol.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import Foundation

protocol NetworkServicesProtocol {
    func searchProducts(searchTerm: String, completion: @escaping ((Result<ProductDetailsResponse, NetworkRequestError>) -> Void))
}
