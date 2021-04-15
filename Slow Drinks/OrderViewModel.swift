//
//  OrderViewModel.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/15.
//

import UIKit

class OrderViewModel {
    
    let apiManager: APIManager
    
    var reloadTableView: (()->())?
    var handleError: ((_ errorCode: Int, _ errorMessage: String)->())?
    
    private var orderViewModels: [DrinksItemViewModel] = [DrinksItemViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    init(_ apiManager: APIManager = APIManager.sharedInstance) {
        self.apiManager = apiManager
        
        if let image = UIImage.init(systemName: "person") {
            orderViewModels = [ DrinksItemViewModel(image: image),
                                DrinksItemViewModel(image: image),
                                DrinksItemViewModel(image: image),
                                DrinksItemViewModel(image: image),
                                DrinksItemViewModel(image: image) ]
        }
    }
    
    func numberOfCells() -> Int {
        return orderViewModels.count
    }
    
    func getCellViewModel(at index: Int) -> DrinksItemViewModel {
        return orderViewModels[index]
    }
    
    func setCellViewModel(_ viewModel: DrinksItemViewModel, index: Int) {
        orderViewModels[index] = viewModel
    }
    
    func createData() {
        apiManager.createData()
    }
}

