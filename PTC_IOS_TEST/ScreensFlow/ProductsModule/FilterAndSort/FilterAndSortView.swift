//
//  FilterAndSortView.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 09/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import HandyUIKit

class FilterAndSortView: UIView, NibLoadable {
    @IBOutlet private var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        try? loadFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        try? loadFromNib()
    }
}
