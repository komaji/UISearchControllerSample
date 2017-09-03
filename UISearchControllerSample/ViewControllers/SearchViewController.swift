//
//  SearchViewController.swift
//  UISearchControllerSample
//
//  Created by KojimaTatsuya on 2017/09/03.
//  Copyright © 2017年 KojimaTatsuya. All rights reserved.
//

import UIKit

enum FoodCategory: String {
    case pizza = "Pizza"
    case humberger = "Humberger"
    case sushi = "Sushi"
    
    static var all: [FoodCategory] {
        return [
            .pizza,
            .humberger,
            .sushi
        ]
    }
    
    var foods: [String] {
        switch self {
        case .pizza:
            return [
                "Margherita",
                "Quattro Formaggi"
            ]
        case .humberger:
            return [
                "Plain",
                "Cheese",
                "Pickles"
            ]
        case .sushi:
            return [
                "Tuna",
                "Salmon",
                "Sea Urchin"
            ]
        }
    }
}

class SearchViewController: UIViewController {
    
    let tableViewCellReuesIdentifier = "SearchTableViewCell"
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
        }
    }
    
    var searchResults = FoodCategory.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
}

// MARK: - UITableViewDatasource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuesIdentifier, for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row].rawValue
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchSecondViewController = SearchSecondViewController.build(foodCategory: FoodCategory.all[indexPath.row])
        navigationController?.pushViewController(searchSecondViewController, animated: true)
    }
    
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
    
        if text.isEmpty {
            searchResults = FoodCategory.all
        } else {
            searchResults = []
            
            FoodCategory.all.forEach { foodCategory in
                if foodCategory.rawValue.contains(text) {
                    searchResults.append(foodCategory)
                }
            }
        }
        
        tableView.reloadData()
    }
    
}
