//
//  ActivityIndicator.swift
//
//  Created by Eslam Salem on 4/24/21.
//
import JGProgressHUD

class ActivityIndicator {
    var progressHud: JGProgressHUD

    init() {
        progressHud = JGProgressHUD()
    }

    func displayForLoading(in view: UIView) {
        progressHud = JGProgressHUD(style: .dark)
        progressHud.textLabel.text = "Loading"
        progressHud.show(in: view)
    }

    func dismiss() {
        progressHud.dismiss(animated: true)
    }
}
