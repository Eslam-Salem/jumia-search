//
//  ErrorResponseModel.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
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
