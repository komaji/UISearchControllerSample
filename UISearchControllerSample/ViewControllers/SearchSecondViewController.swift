//
//  SearchSecondViewController.swift
//  UISearchControllerSample
//
//  Created by KojimaTatsuya on 2017/09/03.
//  Copyright © 2017年 KojimaTatsuya. All rights reserved.
//

import UIKit

class SearchSecondViewController: UIViewController {
    
    static func build(foodCategory: FoodCategory) -> SearchSecondViewController {
        let viewController = SearchSecondViewController.instantiate()
        viewController.foodCategory = foodCategory
        
        return viewController
    }
    
    let tableViewCellReuesIdentifier = "SearchSecondTableViewCell"
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
        }
    }
    
    lazy var searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarButtonDidTap(_:)))
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        
        return searchBar
    }()
    
    var foodCategory: FoodCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    @objc func searchBarButtonDidTap(_ barButtonItem: UIBarButtonItem) {
        navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    
}

// MARK: - UITableViewDatasource
extension SearchSecondViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodCategory.foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuesIdentifier, for: indexPath)
        cell.textLabel?.text = foodCategory.foods[indexPath.row]
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension SearchSecondViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchDetailViewController = SearchDetailViewController.build(food: foodCategory.foods[indexPath.row])
        navigationController?.pushViewController(searchDetailViewController, animated: true)
    }
    
}

// MARK: - UISearchBarDelegate
extension SearchSecondViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
}
