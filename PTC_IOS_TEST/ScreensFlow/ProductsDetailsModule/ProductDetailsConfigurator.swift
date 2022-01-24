//
//  ProductDetailsConfigurator.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

class ProductDetailsConfigurator {
    static func navigateToProductDetails(productID: String, presentingViewController: UIViewController) {
        let detailsViewCtrl = ProductsDetailsViewController()
        detailsViewCtrl.viewModel = ProductDetailsViewModel(productID: productID)
        presentingViewController.navigationController?.pushViewController(detailsViewCtrl, animated: true)
    }
}
