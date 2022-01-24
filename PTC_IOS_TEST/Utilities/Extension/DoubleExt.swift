//
//  DoubleExt.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 09/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
