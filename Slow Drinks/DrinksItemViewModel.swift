//
//  DrinksItemViewModel.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/15.
//

import UIKit

class DrinksItemViewModel {
    
    var updateAmount: ((_ amount: Int)->())?
    
    var counter: Int = 0 {
        didSet {
            amount = counter * 100
        }
    }
    
    var amount: Int = 0 {
        didSet {
            self.updateAmount?(amount)
        }
    }
    
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
}

