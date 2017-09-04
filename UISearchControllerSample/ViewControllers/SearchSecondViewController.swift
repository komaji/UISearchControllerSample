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
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width:  260.0, height: 44.0))
        searchBar.delegate = self
        
        return searchBar
    }()
    
    lazy var searchBarButtonItem = UIBarButtonItem(customView: self.searchBar)
    
    var foodCategory: FoodCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = nil
        navigationItem.rightBarButtonItem = searchBarButtonItem
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.bounds = CGRect(x: 0.0, y: 0.0, width: 345.0, height: 44.0)
        searchBar.showsCancelButton = true
        navigationItem.hidesBackButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.bounds = CGRect(x: 0.0, y: 0.0, width: 260.0, height: 44.0)
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        navigationItem.hidesBackButton = false
        navigationItem.rightBarButtonItem = nil
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
}
