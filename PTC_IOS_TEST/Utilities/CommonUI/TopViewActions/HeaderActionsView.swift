//
//  HeaderActionsView.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import HandyUIKit

class HeaderActionsView: UIView, NibLoadable {
    var goBackHandler: (() -> Void)?
    var searchForNewItem: (() -> Void)?
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var searchButton: UIButton!
    @IBOutlet private var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        try? loadFromNib()
        configureDesign()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        try? loadFromNib()
        configureDesign()
    }
    
    @IBAction private func goBack() {
        goBackHandler?()
    }

    @IBAction private func clickOnSearch() {
        textField.isUserInteractionEnabled = true
        textField.becomeFirstResponder()
    }

    func getTextFiledText() -> String {
        return textField.text ?? ""
    }

    private func configureDesign() {
        textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
    }
    
    @objc func doneButtonClicked() {
        searchForNewItem?()
    }
}
