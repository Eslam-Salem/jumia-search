//
//  SplashScreenViewModel.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SplashScreenViewModel {
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    func requestUserConfiguration() {
        let endPoint = EndPoints.shared.requestProjectConfiguration()
        guard let url = URL(string: endPoint) else {
            self.error.onNext("Unknown Error")
            return
        }
        self.loading.onNext(true)
        APIClient.request(
            url: url,
            httpMethod: .get,
            responseType: ConfigurationsResponseModel.self,
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
    
    private func handleDataResponse(response: ConfigurationsResponseModel) {
        guard response.success else {
            error.onNext(response.messages?.error?.message ?? "Unknown Error")
            return
        }
        UserConfigurations.shared.setUserInfo(
            currencyUniCode: response.metadata?.currency.currencySymbol,
            languageSelected: response.metadata?.languages.first?.name
        )
    }
}
