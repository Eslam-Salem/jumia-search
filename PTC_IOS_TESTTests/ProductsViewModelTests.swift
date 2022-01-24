//
//  ProductsViewModelTests.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 09/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import XCTest
@testable import PTC_IOS_TEST

class ProductsViewModelTests: XCTestCase {
    var sutViewModel = ProductsViewModel()
    
    override func setUp() {
        super.setUp()
        let products = [
            ProductModel(name: "firstOne", productID: "1"),
            ProductModel(name: "secondOne", productID: "2")
        ]
        sutViewModel.productsDataSource = products
    }

    override func tearDown() {
        sutViewModel.resetDataSource()
        super.tearDown()
    }
    
    func testShouldPaginate() {
        sutViewModel.totalProductsNumber = 20
        XCTAssertTrue(sutViewModel.shouldPaginateMore)
    }
    
    func testShouldnotPaginate() {
        sutViewModel.totalProductsNumber = 2
        XCTAssertFalse(sutViewModel.shouldPaginateMore)
    }
    
    func testSelectProductInRange() {
        let selectedProductID = sutViewModel.getProductIDForProduct(at: 1)
        XCTAssertNotNil(selectedProductID)
    }
    
    func testSelectProductOutOfRange() {
        let selectedProductID = sutViewModel.getProductIDForProduct(at: 5)
        XCTAssertNil(selectedProductID)
    }
}
