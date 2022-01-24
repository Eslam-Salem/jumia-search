//
//  UICollectionViewExt.swift
//  PTC_IOS_TEST
//
//  Created by Eslam Salem on 08/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: "\(Cell.self)", for: indexPath) as? Cell ?? Cell()
    }

    /// Registers a nib with the name of `cellType` if it exists or registers the class of type `cellType` as reusable cell.
    func registerCell<Cell: UICollectionViewCell>(ofType cellType: Cell.Type) {
        let cellTypeName = String(describing: cellType)

        if Bundle.main.path(forResource: cellTypeName, ofType: "nib") != nil {
            register(UINib(nibName: cellTypeName, bundle: .main), forCellWithReuseIdentifier: cellTypeName)
        } else {
            register(cellType, forCellWithReuseIdentifier: cellTypeName)
        }
    }
}
