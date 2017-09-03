//
//  SearchDetailViewController.swift
//  UISearchControllerSample
//
//  Created by KojimaTatsuya on 2017/09/03.
//  Copyright © 2017年 KojimaTatsuya. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    static func build(food: String) -> SearchDetailViewController {
        let viewController = SearchDetailViewController.instantiate()
        viewController.food = food
        
        return viewController
    }
    
    @IBOutlet weak var foodCategoryLabel: UILabel!
    
    var food: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodCategoryLabel.text = food
    }
    
}
