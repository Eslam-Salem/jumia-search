//
//  ProductDetailsView.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import Foundation
import SDWebImageSwiftUI

struct ProductDetailsView: View {
    
    @ObservedObject var viewModel: ProductDetailsViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            if let url = URL(string: viewModel.selectedImage) {
                WebImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250.0, height: 250.0, alignment: .center)
                    .clipped()
            }
            Group {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.top, 10)
                    
                    HStack {
                        Text(String(describing: viewModel.productDetails?.currentPrice ?? 0))
                            .font(.system(size: 17))
                            .foregroundColor(Color.black)
                        Text(String(describing: viewModel.productDetails?.oldPrice ?? 0))
                            .font(.system(size: 17))
                            .foregroundColor(Color.gray)
                            .overlay(
                                Rectangle().frame(height: 1).offset(y: 0).foregroundColor(Color.gray), alignment: .center)
                        Spacer()
                            .frame(width: 15)
                        ZStack {
                            Text("\(viewModel.productDetails?.discount ?? 0)%")
                                .font(.system(size: 12))
                                .foregroundColor(Color.darkYellow)
                        }
                        .frame(width: 50, height: 30)
                        .border(Color.darkYellow, width: 2)
                    }
                    .padding(.top, 15)
                    Divider().padding(.top, 10)
                    
                    let ratingTotalUsers = viewModel.productDetails?.ratingTotal ?? 0
                    let ratingAverage = viewModel.productDetails?.ratingAverage ?? 0
                    HStack {
                        MyCosmosView(rating: .constant(ratingAverage), starSize: 27)
                        Text("\(ratingTotalUsers) Rating")
                            .font(.system(size: 14))
                            .foregroundColor(Color.blue)
                            .padding(.horizontal, 10)
                    }
                    .padding(.top, 15)
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Text("Specifications")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                        .padding(.horizontal, 15)
                    
                    Spacer()
                    
                }
                .frame(height: 60)
                .background(Color.backGroundGray)
                
                Text(String(describing: viewModel.productDetails?.description ?? ""))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14))
                    .foregroundColor(Color.black)
                    .padding([.horizontal, .top], 10)
            }
        }
        Spacer()
        HStack(spacing: 0) {
            Button {
            } label: {
                ZStack {
                    Color.black
                    Image("shared")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                }
                .frame(width: 80, height: 60, alignment: .center)
            }
            Button {
            } label: {
                ZStack {
                    Color.darkYellow
                    Text("Buy Now")
                        .font(.system(size: 22))
                        .foregroundColor(Color.white)
                }
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 10)
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var viewModel = ProductDetailsViewModel(productID: "")
    static var previews: some View {
        ProductDetailsView(viewModel: viewModel)
    }
}

extension Color {
    static let darkYellow = Color("darkYellow")
    static let backGroundGray = Color("grayBG")
}
