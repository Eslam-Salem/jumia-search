//
//  ProductsDetailsViewController.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsDetailsViewController: UIViewController {
    private var containerStackView: UIStackView!
    private var headerActionsView: HeaderActionsView!
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()
    private var alertView: AlertHandler?
    
    var viewModel: ProductDetailsViewModel?
    
    //MARK: -  Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupScreenDesign()
        viewModel?.requestProductsDetails()
        configureAlert()
    }

    private func configureAlert() {
        alertView = AlertHandler(presentingViewCtrl: self)
    }
    
    //MARK: -  Design Methods
    
    private func setupScreenDesign(shouldShowProductDetailsView: Bool = false) {
        addContainerStackView()
        addTopActionView()
        setupProductDetailsView(shouldShowProductDetailsView: shouldShowProductDetailsView)
    }

    private func addContainerStackView() {
        containerStackView = UIStackView(frame: view.frame)
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        view.addSubview(containerStackView)
    }
    
    private func addTopActionView() {
        headerActionsView = HeaderActionsView()
        headerActionsView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        headerActionsView.isSearchingEnabled = false
        headerActionsView.goBackHandler = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        containerStackView.addArrangedSubview(headerActionsView)
    }
    
    private func setupProductDetailsView(shouldShowProductDetailsView: Bool) {
        let swuiftUIViewContainer = UIView()
        swuiftUIViewContainer.backgroundColor = .white
        containerStackView.addArrangedSubview(swuiftUIViewContainer)
        if let viewModel = viewModel, shouldShowProductDetailsView {
            let swiftUIView = ProductDetailsView(viewModel: viewModel)
            addSubSwiftUIView(swiftUIView, to: swuiftUIViewContainer)
        }
    }
    
    //MARK: -  Binding Methods

    private func bindViewModel() {
        bindLoading()
        bindError()
        bindIsResponseReturned()
    }

    private func bindLoading() {
        viewModel?
            .loading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                isLoading
                ? self.activityIndicator.displayForLoading(in: self.view)
                : self.activityIndicator.dismiss()
            })
            .disposed(by: disposeBag)
    }

    private func bindIsResponseReturned() {
        viewModel?
            .isResponseReturned
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isResponseReturned in
                self?.setupScreenDesign(shouldShowProductDetailsView: isResponseReturned)
            })
            .disposed(by: disposeBag)
    }

    private func bindError() {
        viewModel?
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.alertView?.showErrorMessage(message: error) { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
