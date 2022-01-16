//
//  ProductSearchViewController.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import UIKit

class ProductSearchViewController: UIViewController {
    
    let viewModel = ProductSearchViewModel()

    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .green
        return searchBar
    }()
    
    lazy var searchResultsTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        searchBar.becomeFirstResponder()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        addViews()
        setConstraints()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        view.addSubview(searchBar)
        view.addSubview(searchResultsTable)
        
        searchBar.delegate = self
        searchResultsTable.dataSource = self
        searchResultsTable.register(ProductDetailsCell.self)
    }
    
   private func setConstraints() {
        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: guide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            
            searchBar.bottomAnchor.constraint(equalTo: searchResultsTable.topAnchor),
            searchResultsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.products.addObserver(on: self) { [weak self] _ in
            DispatchQueue.main.async {
                self?.searchResultsTable.reloadData()
            }
        }
        
        viewModel.fetchError.addObserver(on: self) { [weak self] error in
            guard let error = error else {
                return
            }
            
            self?.showAlert(for: error)
        }
    }
    
}

extension ProductSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }

        searchBar.endEditing(false)
        viewModel.clearCurrentProducts()
        viewModel.searchProducts(with: searchText)
    }
}

extension ProductSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productDetailsCell = searchResultsTable.dequeueReusableCell(withIdentifier: ProductDetailsCell.defaultIdentifier, for: indexPath) as? ProductDetailsCell,
            indexPath.row < viewModel.products.value.count
        else {
            return UITableViewCell()
        }

        let cellViewModel = ProductDetailsCellViewModel(productData: viewModel.products.value[indexPath.row])
        productDetailsCell.cellViewModel = cellViewModel
        
        return productDetailsCell
    }
    
}
