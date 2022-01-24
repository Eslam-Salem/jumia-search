//
//  ProductCollectionViewCell.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import Cosmos

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var brandNameLabel: UILabel!
    @IBOutlet private var productNameLabel: UILabel!
    @IBOutlet private var priceAfterDiscountLabel: UILabel!
    @IBOutlet private var priceBeforeDiscountLabel: UILabel!
    @IBOutlet private var discountLabel: UILabel!
    @IBOutlet private var discountView: UIView!
    @IBOutlet private var productImageView: UIImageView!
    @IBOutlet private var ratingView: CosmosView!
    @IBOutlet private var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        handleCellDesign()
    }

    var cellProduct: ProductModel! {
        didSet {
            configureCellData(product: cellProduct)
        }
    }
    
    private func configureCellData(product: ProductModel) {
        brandNameLabel.text = product.brand
        productNameLabel.text = product.name
        ratingView.rating = product.rating ?? 0.0
        productImageView.setCacheableImage(imageUrlPath: product.imageUrl)
        let currencySymbol = UserConfigurations.shared.currencyUniCode ?? ""
        if let currentPrice = product.currentPrice {
            priceAfterDiscountLabel.text = "\(currencySymbol) \(currentPrice)"
        }
        if let oldPrice = product.oldPrice {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(currencySymbol) \(oldPrice)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            priceBeforeDiscountLabel.attributedText = attributeString
        }
        if let percentage = product.discountPercentage {
            discountLabel.text = "\(percentage)%"
        } else {
            discountView.isHidden = true
        }
    }

    private func handleCellDesign() {
        discountView.setBorder(
            color: .orange,
            width: 0.5,
            cornerRadius: 2
        )
        containerView.setBorder(
            color: .lightGray,
            width: 0.5,
            cornerRadius: 0
        )
    }
}
