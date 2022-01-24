//
//  EndPoints.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 07/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

class EndPoints {
    static let shared = EndPoints()
    private let baseURL = "http://nd7d1.mocklab.io/"
    
    private init() {}
    
    func searchForProducts(key: String, pageNumber: Int) -> String {
        let url = baseURL + "search/\(key)/page/\(pageNumber)/"
        return url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    func requestProjectConfiguration() -> String {
        let url = baseURL + "configurations/"
        return url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    func requestProductDetails(productID: String) -> String {
        let url = baseURL + "product/\(productID)/"
        return url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
