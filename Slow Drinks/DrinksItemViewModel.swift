//
//  DrinksItemViewModel.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/15.
//

import UIKit

class DrinksItemViewModel {
    
    var updateAmount: (()->())?
    
    var counter: Int = 0 {
        didSet {
            amount = counter * price
        }
    }
    
    var amount: Int = 0 {
        didSet {
            self.updateAmount?()
        }
    }
    
    var price: Int
    var image: UIImage
    
    init(price: Int, image: UIImage) {
        self.price = price
        self.image = image
    }
    
    func resetData() {
        counter = 0
    }
}

