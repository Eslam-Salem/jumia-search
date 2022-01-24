//
//  AlertHandler.swift
//
//  Created by Eslam Salem on 4/24/21.
//

import Foundation
import UIKit

class AlertHandler {
    private weak var presentingViewCtrl: UIViewController?

    init(presentingViewCtrl: UIViewController) {
        self.presentingViewCtrl = presentingViewCtrl
    }

    func showErrorMessage(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { UIAlertAction in
            if let completion = completion { completion() }
        }
        alert.addAction(okAction)
        presentingViewCtrl?.present(alert, animated: true)
    }
}
