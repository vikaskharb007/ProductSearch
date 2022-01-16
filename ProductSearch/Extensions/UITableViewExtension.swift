//
//  UITableViewExtension.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 16/01/2022.
//

import UIKit

extension UITableView {
    func register<T: RegistrableCellProtocol>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultIdentifier)
    }
}
