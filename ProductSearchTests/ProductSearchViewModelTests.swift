//
//  ProductSearchViewModelTests.swift
//  ProductSearchTests
//
//  Created by Vikas Kharb on 15/01/2022.
//

import XCTest
@testable import ProductSearch

class ProductSearchViewModelTests: XCTestCase {
    
    var viewModel: ProductSearchViewModel = ProductSearchViewModel(service: MockNetworkManager.shared)

    override func setUpWithError() throws {
        viewModel.clearCurrentProducts()
    }

    func testDataDownload() {
        viewModel.products.addObserver(on: self) { [weak self] products in
            XCTAssertEqual(products.count, 4)
            XCTAssertEqual(self?.viewModel.products.value.count, 4)
        }
    
        viewModel.searchProducts(with: "Search")
    }
    
    func testFetchError() {
        viewModel.fetchError.addObserver(on: self) { [weak self] error in
                
            XCTAssertEqual(self?.viewModel.products.value.count, 0)
            XCTAssertNotNil(self?.viewModel.fetchError.value)
        }
    
        viewModel.searchProducts(with: "InvalidSearch")
    }

}
