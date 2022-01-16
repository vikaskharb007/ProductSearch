//
//  RegistrableCellProtocol.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import UIKit

protocol RegistrableCellProtocol: UITableViewCell {
    static var defaultIdentifier: String { get }
}

extension RegistrableCellProtocol {
    static var defaultIdentifier: String {
        return String(describing: self)
    }
}
