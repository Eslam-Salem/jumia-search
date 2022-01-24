//
//  SplashScreenViewController.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SplashScreenViewController: UIViewController {
    private var logoImageView: UIImageView!
    private var viewModel = SplashScreenViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureDesign()
        setupImageView()
        requestConfigurations()
    }

    private func requestConfigurations() {
        viewModel.requestUserConfiguration()
    }

    private func setupImageView() {
        logoImageView = UIImageView(frame: view.frame)
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        logoImageView.image = UIImage.jumiaLogo
        logoImageView.contentMode = .scaleAspectFit
    }

    private func configureDesign() {
        view.backgroundColor = .darkYellow
    }

    //MARK: -  binding Methods

    private func bindViewModel() {
        bindLoading()
    }
    
    private func bindLoading() {
        viewModel
            .loading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                if !isLoading {
                    self?.navigateToProductsApp()
                }
            })
            .disposed(by: disposeBag)
    }

    private func navigateToProductsApp() {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window
        else {
            return
        }
        let navigationController = UINavigationController()
        let mainView = ProductsViewController()
        navigationController.navigationBar.isHidden = true
        navigationController.viewControllers = [mainView]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
