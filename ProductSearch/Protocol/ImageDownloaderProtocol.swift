//
//  ImageDownloaderProtocol.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import UIKit

protocol ImageDownloaderProtocol: AnyObject {
    var downloadedImage: ObservableProperty<UIImage> { get set }
    var imageDownloadError: ObservableProperty<NetworkRequestError?> { get set }
}

extension ImageDownloaderProtocol {
    func downloadImage(imageURL: String) {
        NetworkManager.shared.getImage(url: imageURL) { [weak self] result in
            switch result {
            case .success( let imageData):
                guard let image = UIImage(data: imageData) else {
                    return
                }
                
                self?.downloadedImage.value = image
                
            case .failure:
                self?.imageDownloadError.value = .apiError("Failed to download Image")
            }
        }
    }
}
