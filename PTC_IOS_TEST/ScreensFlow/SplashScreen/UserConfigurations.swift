//
//  UserConfigurations.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

class UserConfigurations {
    static let shared = UserConfigurations()
    
    private init() {}
    
    var currencyUniCode: String?
    var languageSelected: String?

    func setUserInfo(currencyUniCode: String?, languageSelected: String?) {
        self.currencyUniCode = currencyUniCode
        self.languageSelected = languageSelected
    }
}
