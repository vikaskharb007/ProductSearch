//
//  ProductDetailsCellViewModel.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import UIKit

class ProductDetailsCellViewModel: ImageDownloaderProtocol {
    var productDetails: SearchedProductsModel
    var downloadedImage: ObservableProperty<UIImage> = ObservableProperty(UIImage())
    var imageDownloadError: ObservableProperty<NetworkRequestError?> = ObservableProperty(nil)
    
    init(productData: SearchedProductsModel) {
        self.productDetails = productData
    }
}
