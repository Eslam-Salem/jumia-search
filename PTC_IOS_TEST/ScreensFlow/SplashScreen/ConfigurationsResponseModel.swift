//
//  ConfigurationsResponseModel.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

struct ConfigurationLanguageResponseModel: Decodable {
    var code: String
    var name: String
}

struct ConfigurationCurrencyResponseModel: Decodable {
    var iso: String
    var currencySymbol: String
}

struct ConfigurationsMetaDataResponseModel: Decodable {
    var currency: ConfigurationCurrencyResponseModel
    var languages: [ConfigurationLanguageResponseModel]
}

struct ConfigurationsResponseModel: Decodable {
    var success: Bool
    var metadata: ConfigurationsMetaDataResponseModel?
    var messages: ErrorMessagesResponseModel?
}
