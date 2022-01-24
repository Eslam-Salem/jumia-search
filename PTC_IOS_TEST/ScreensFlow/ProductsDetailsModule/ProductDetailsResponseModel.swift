//
//  ProductDetailsResponseModel.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 09/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

struct ProductDetailsSummaryResponseModel: Decodable {
    var shortDescription: String?
    var description: String?
}

struct ProductDetailsRatingResponseModel: Decodable {
    var average: Double?
    var ratingsTotal: Int?
}
    
struct ProductDetailsMetaDataResponseModel: Decodable {
    var name: String?
    var maxSavingPercentage: Int?
    var price: Double?
    var specialPrice: Double?
    var brand: String?
    var rating: ProductDetailsRatingResponseModel?
    var imageList: [String]?
    var summary: ProductDetailsSummaryResponseModel?
}

struct ProductDetailsResponseModel: Decodable {
    var success: Bool
    var metadata: ProductDetailsMetaDataResponseModel?
    var messages: ErrorMessagesResponseModel?
}
