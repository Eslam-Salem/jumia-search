//
//  ProductsViewController.swift
//  PTC_IOS_TEST
//
//  Created by Tiago Valente on 27/06/2019.
//  Copyright © 2019 Jumia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UIScrollView_InfiniteScroll

class ProductsViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var headerActionsView: HeaderActionsView!
    private var filterAndSortView: FilterAndSortView!
    private var containerStackView: UIStackView!

    private let viewModel = ProductsViewModel()
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()
    private var alertView: AlertHandler?

    //MARK: -  Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreenDesign()
        configureCollectionViewLayout()
        bindViewModel()
        configureAlert()
        registerCollectionViewNib()
        requestList()
        configureInfiniteScrolling()
        handleSelectionOnCollectionViewCell()
    }

    private func requestList() {
        let searchText = headerActionsView.getTextFiledText()
        viewModel.requestProductsListFor(searchingKey: searchText)
    }

    private func configureAlert() {
        alertView = AlertHandler(presentingViewCtrl: self)
    }
    
    //MARK: -  Design Methods
    private func configureScreenDesign() {
        addContainerStackView()
        addTopActionView()
        addFiltersAndSortView()
        addCollectionView()
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
        headerActionsView.isSearchingEnabled = true
        headerActionsView.searchForNewItem = { [weak self] in
            self?.viewModel.resetDataSource()
            self?.requestList()
        }
        containerStackView.addArrangedSubview(headerActionsView)
    }
    
    private func addFiltersAndSortView() {
        filterAndSortView = FilterAndSortView()
        filterAndSortView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        containerStackView.addArrangedSubview(filterAndSortView)
    }
    
    private func addCollectionView() {
        collectionView = UICollectionView(frame: containerStackView.frame, collectionViewLayout: UICollectionViewFlowLayout())
        containerStackView.addArrangedSubview(collectionView)
    }
    
    //MARK: -  collection View Methods
    
    private func registerCollectionViewNib() {
        collectionView.registerCell(ofType: ProductCollectionViewCell.self)
    }

    private func configureInfiniteScrolling() {
        collectionView?.addInfiniteScroll { [weak self] _ in
            guard let self = self,
                  self.viewModel.shouldPaginateMore
            else {
                self?.collectionView.finishInfiniteScroll()
                return
            }
            self.viewModel.pageNumber += 1
            self.requestList()
        }
    }

    private func configureCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets.zero
        view.layoutIfNeeded()
        let cellWidth = (collectionView.frame.size.width) / CGFloat(2)
        flowLayout.itemSize = CGSize(width: cellWidth, height: 350)
        collectionView?.setCollectionViewLayout(flowLayout, animated: true)
    }

    private func handleSelectionOnCollectionViewCell() {
        collectionView
            .rx
            .itemSelected
                .subscribe(onNext:{ [weak self] indexPath in
                    guard let self = self,
                          let selectedProductID = self.viewModel.getProductIDForProduct(at: indexPath.row)
                    else { return }
                    ProductDetailsConfigurator.navigateToProductDetails(productID: selectedProductID, presentingViewController: self)
                }).disposed(by: disposeBag)
    }

    //MARK: -  binding Methods

    private func bindViewModel() {
        bindLoading()
        bindError()
        bindProductsResponse()
    }

    private func bindLoading() {
        viewModel
            .loading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                self?.handleLoadingIndicator(isLoading: isLoading)
            })
            .disposed(by: disposeBag)
    }

    private func handleLoadingIndicator(isLoading: Bool) {
        if isLoading, viewModel.pageNumber == 1 {
            activityIndicator.displayForLoading(in: view)
        } else {
            activityIndicator.dismiss()
            collectionView.finishInfiniteScroll()
        }
    }

    private func bindError() {
        viewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.alertView?.showErrorMessage(message: error)
            })
            .disposed(by: disposeBag)
    }

    private func bindProductsResponse() {
        viewModel
            .products
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: "\(ProductCollectionViewCell.self)", cellType: ProductCollectionViewCell.self)) { (row,product,cell) in
                cell.cellProduct = product
                }
            .disposed(by: disposeBag)
    }
}
