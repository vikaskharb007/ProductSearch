//
//  ProductSearchViewModel.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import Foundation

struct SearchedProductsModel {
    var name: String
    var price: String
    var productUSPs: String
    var productImage: String
    var productRating: String?
    var productAvailableTommorow: Bool
}

class ProductSearchViewModel {
    let networkService: NetworkServicesProtocol
    
    var products: ObservableProperty<[SearchedProductsModel]> = ObservableProperty([SearchedProductsModel]())
    var fetchError: ObservableProperty<NetworkRequestError?> = ObservableProperty(nil)
    
    init(service: NetworkServicesProtocol = NetworkManager.shared) {
        networkService = service
    }
    
    func searchProducts(with searchTerm: String) {
        networkService.searchProducts(searchTerm: searchTerm) { [weak self] result in
            switch result {
            
            case .success(let response):
                guard let products = response.products else {
                    self?.fetchError.value = NetworkRequestError.jsonParseError
                    return
                }
                
                self?.extractProductDetails(products: products)
                
            case .failure(let error):
                self?.fetchError.value = NetworkRequestError.apiError(error.localizedDescription)
            }
        }
    }
    
    private func extractProductDetails(products: [Product]) {
        print("extract products called")
        self.products.value = products.map { product in
            
            SearchedProductsModel(name: product.productName ?? "",
                                  price: product.salesPriceIncVat?.formattedAmount ?? "",
                                  productUSPs: product.USPs?.reduce("", { $0 == "   * " ? $1 : $0 + "\n" + "   * " +  $1 }) ?? "",
                                  productImage: product.productImage ?? "",
                                  productRating:  product.reviewInformation?.reviewSummary?.reviewAverage?.formattedAmount,
                                  productAvailableTommorow: product.nextDayDelivery ?? false) }
    }
    
     func clearCurrentProducts() {
        products.value.removeAll()
        fetchError.value = nil
    }
}
