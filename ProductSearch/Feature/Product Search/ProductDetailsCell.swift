//
//  ProductDetailsCell.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import UIKit

class ProductDetailsCell: UITableViewCell, RegistrableCellProtocol {
    let containerView: UIView = {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let productImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let productDetailsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        stack.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.00)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let uspLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nextDayDeliveryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Delivered tommorow"
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cellViewModel: ProductDetailsCellViewModel? {
        didSet {
            publishDetails()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = ProductDetailsCell.defaultIdentifier) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        priceLabel.text = ""
        ratingLabel.text = ""
        uspLabel.text = ""
        productImageview.image = nil
    }
    
    func setupView() {
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        // Product details Stack
        [nameLabel,ratingLabel, uspLabel, priceLabel , nextDayDeliveryLabel].forEach { detail in
            productDetailsStack.addArrangedSubview(detail)
        }
        
        // Container View
        containerView.addSubview(productImageview)
        containerView.addSubview(productDetailsStack)
        
        contentView.addSubview(containerView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            productImageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            productImageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageview.trailingAnchor.constraint(equalTo: productDetailsStack.leadingAnchor, constant: -10),
            
            productDetailsStack.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            productDetailsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            productDetailsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            productImageview.widthAnchor.constraint(equalToConstant: 100),
            productImageview.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func publishDetails() {
        guard let viewModel = cellViewModel else {
            return
        }
        
        bindViewModel()
        
        nameLabel.text = viewModel.productDetails.name
        priceLabel.text = viewModel.productDetails.price
        ratingLabel.text = "Customer Rating: " + (viewModel.productDetails.productRating ?? "Unavailable")
        uspLabel.text = viewModel.productDetails.productUSPs
        nextDayDeliveryLabel.isHidden = !(viewModel.productDetails.productAvailableTommorow)
        viewModel.downloadImage(imageURL: viewModel.productDetails.productImage)
    }
    
    private func bindViewModel() {
        cellViewModel?.downloadedImage.addObserver(on: self, notifyBlock: { image in
            DispatchQueue.main.async {
                self.productImageview.image = image
            }
        })
    }
}
