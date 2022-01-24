//
//  ProductImageView.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ProductImageView: View {
    
    let productImage: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                if let url = URL(string: productImage) {
                    WebImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40.0, height: 40.0, alignment: .center)
                    .padding()
                }
            }
            .border(isActive ? Color.darkYellow : Color(UIColor.lightGray), width: 1)
        }
    }
}

struct ProductImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductImageView(productImage: "2", isActive: false, action: {})
    }
}
