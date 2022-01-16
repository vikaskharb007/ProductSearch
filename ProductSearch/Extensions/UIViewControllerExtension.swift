//
//  UIViewControllerExtension.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import UIKit

extension UIViewController {
        func showAlert(for error: NetworkRequestError, actions: [UIAlertAction]? = nil, completion: (()-> Void)? = nil) {
            let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
            
            let availableActions = actions ?? [UIAlertAction(title: "Ok", style: .destructive, handler: nil)]
            availableActions.forEach { alert.addAction($0) }
            
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: completion)
            }
        }
}
