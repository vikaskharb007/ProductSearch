//
//  ProductResponse.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import Foundation

struct ProductDetailsResponse: Codable {
    var products: [Product]?
    var currentPage: Int
    var pageSize: Int
    var totalResults: Int
    var pageCount: Int
}

struct Product: Codable {
    var productId: Int
    var productName: String?
    var reviewInformation: ReviewInformation?
    var USPs: [String]?
    var salesPriceIncVat: Decimal?
    var productImage: String?
    var nextDayDelivery : Bool?
}

struct ReviewInformation: Codable {
    var reviewSummary: ReviewSummary?
}

struct ReviewSummary: Codable {
    var reviewAverage: Decimal?
    var reviewCount: Int
}
