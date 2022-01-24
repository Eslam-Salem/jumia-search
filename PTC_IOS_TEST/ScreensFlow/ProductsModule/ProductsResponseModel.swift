//
//  ProductsResponseModel.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 07/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

struct ErrorDetailsResponseModel: Decodable {
    var reason: String?
    var message: String?
}

struct ErrorMessagesResponseModel: Decodable {
    var error: ErrorDetailsResponseModel?
}

struct ProductsResultsResponseModel: Decodable {
    var sku: String?
    var name: String?
    var brand: String?
    var maxSavingPercentage: Int?
    var price: Double?
    var specialPrice: Double?
    var image: String?
    var ratingAverage: Double?
}

struct ProductsMetaDataResponseModel: Decodable {
    var totalProducts: Int?
    var results: [ProductsResultsResponseModel]?
}

struct ProductsListResponseModel: Decodable {
    var success: Bool
    var metadata: ProductsMetaDataResponseModel?
    var messages: ErrorMessagesResponseModel?
}
