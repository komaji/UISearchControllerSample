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
}

class SearchViewController: UIViewController {
    
    let foodCategories: [FoodCategory] = [
        .pizza,
        .humberger,
        .sushi
    ]
    
    let tableViewCellReuesIdentifier = "SearchTableViewCell"
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
        }
    }
    
}

// MARK: - UITableViewDatasource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuesIdentifier, for: indexPath)
        cell.textLabel?.text = foodCategories[indexPath.row].rawValue
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchDetailViewController = SearchDetailViewController.build(foodCategory: foodCategories[indexPath.row])
        navigationController?.pushViewController(searchDetailViewController, animated: true)
    }
    
}
