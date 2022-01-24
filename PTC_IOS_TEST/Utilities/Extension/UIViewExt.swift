//
//  UIViewExt.swift
//
//  Created by Eslam Salem on 4/23/21.
//

import UIKit

extension UIView {
    func setBorder(color: UIColor, width: CGFloat, cornerRadius: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
    }
}
