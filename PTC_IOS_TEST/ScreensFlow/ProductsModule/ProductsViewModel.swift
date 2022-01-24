//
//  ProductsViewModel.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 07/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductsViewModel {
    var productsDataSource = [ProductModel]()

    var products = ReplaySubject<[ProductModel]>.createUnbounded()
    let loading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    var pageNumber = 1
    var totalProductsNumber: Int?
    var shouldPaginateMore: Bool {
        guard let totalProductsNumber = totalProductsNumber else {
            return true
        }
        return productsDataSource.count != totalProductsNumber
    }
    //MARK: -  Methods
    func requestProductsListFor(searchingKey: String) {
        let endPoint = EndPoints.shared.searchForProducts(key: searchingKey, pageNumber: pageNumber)
        guard let url = URL(string: endPoint) else {
            self.error.onNext("Unknown Error")
            return
        }
        loading.onNext(true)
        APIClient.request(
            url: url,
            httpMethod: .get,
            responseType: ProductsListResponseModel.self,
            decoder: JSONDecoder.defaultDecoder
        ) { [weak self] response, error in
            self?.loading.onNext(false)
            guard let response = response, error == nil else {
                self?.error.onNext(error?.localizedDescription ?? "Unknown Error")
                return
            }
            self?.handleDataResponse(response: response)
        }
    }

    private func handleDataResponse(response: ProductsListResponseModel) {
        guard response.success else {
            error.onNext(response.messages?.error?.message ?? "Unknown Error")
            return
        }
        generateProductsDataSource(from: response)
    }

    private func generateProductsDataSource(from response: ProductsListResponseModel) {
        if pageNumber == 1 {
            productsDataSource.removeAll()
        }
        totalProductsNumber = response.metadata?.totalProducts
        if let responseResults = response.metadata?.results  {
            for item in responseResults {
                let product = mapResultToProductModel(item)
                productsDataSource.append(product)
            }
            products.onNext(productsDataSource)
        }
    }

    private func mapResultToProductModel(_ item: ProductsResultsResponseModel) -> ProductModel {
        return ProductModel(
            imageUrl: item.image,
            name: item.name,
            brand: item.brand,
            currentPrice: item.specialPrice,
            oldPrice: item.price,
            discountPercentage: item.maxSavingPercentage,
            rating: item.ratingAverage,
            productID: item.sku
        )
    }

    func resetDataSource() {
        pageNumber = 1
        productsDataSource.removeAll()
        products.onNext(productsDataSource)
    }
}
