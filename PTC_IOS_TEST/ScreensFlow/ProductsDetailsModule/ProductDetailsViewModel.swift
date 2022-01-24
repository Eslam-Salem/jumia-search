//
//  ProductDetailsViewModel.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductDetailsViewModel: ObservableObject {
    @Published var productDetails: ProductDetailsModel?
    @Published var selectedImage: String = ""

    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let isResponseReturned: PublishSubject<Bool> = PublishSubject()
    
    private var productID: String
    
    init(productID: String) {
        self.productID = productID
    }

    func requestProductsDetails() {
        let endPoint = EndPoints.shared.requestProductDetails(productID: productID)
        guard let url = URL(string: endPoint) else {
            isResponseReturned.onNext(false)
            error.onNext("Unknown Error")
            return
        }
        loading.onNext(true)
        APIClient.request(
            url: url,
            httpMethod: .get,
            responseType: ProductDetailsResponseModel.self,
            decoder: JSONDecoder.defaultDecoder
        ) { [weak self] response, error in
            self?.loading.onNext(false)
            guard let response = response, error == nil else {
                self?.isResponseReturned.onNext(false)
                self?.error.onNext(error?.localizedDescription ?? "Unknown Error")
                return
            }
            self?.handleDataResponse(response: response)
        }
    }

    private func handleDataResponse(response: ProductDetailsResponseModel) {
        guard response.success else {
            isResponseReturned.onNext(false)
            error.onNext(response.messages?.error?.message ?? "Unknown Error")
            return
        }
        isResponseReturned.onNext(true)
        productDetails = ProductDetailsModel(
            images: response.metadata?.imageList ?? [],
            currentPrice: response.metadata?.specialPrice ?? 0.0,
            oldPrice: response.metadata?.price ?? 0.0,
            discount: response.metadata?.maxSavingPercentage ?? 0,
            ratingAverage: response.metadata?.rating?.average ?? 0.0,
            ratingTotal: response.metadata?.rating?.ratingsTotal ?? 0,
            description: response.metadata?.summary?.shortDescription ?? ""
        )
        selectedImage = productDetails?.images.first ?? ""
    }
}
