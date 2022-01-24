//
//  UIImageViewExt.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setCacheableImage(imageUrlPath: String?) {
        kf.indicatorType = .activity
        if let imageUrlPath = imageUrlPath,
           let imageUrl = URL(string: imageUrlPath) {
            kf.setImage(with: imageUrl)
        } else {
            self.image = UIImage(named: "JumiaLogo")
        }
    }
}
