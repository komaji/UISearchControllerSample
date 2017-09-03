//
//  SearchDetailViewController.swift
//  UISearchControllerSample
//
//  Created by KojimaTatsuya on 2017/09/03.
//  Copyright © 2017年 KojimaTatsuya. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    static func build(foodCategory: FoodCategory) -> SearchDetailViewController {
        let viewController = SearchDetailViewController.instantiate()
        viewController.foodCategory = foodCategory
        
        return viewController
    }
    
    @IBOutlet weak var foodCategoryLabel: UILabel!
    
    var foodCategory: FoodCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodCategoryLabel.text = foodCategory.rawValue
    }
    
}
