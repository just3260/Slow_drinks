//
//  OrderViewModel.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/15.
//

import UIKit
import Moya
import RxSwift
import RxMoya

class OrderViewModel {
    
    let apiManager: APIManager
    
    let bag = DisposeBag()
    
    var reloadTableView: (()->())?
    var showSuccess: (()->())?
    var handleError: ((_ errorCode: Int, _ errorMessage: String)->())?
    
    var gender: Gender = .male
    
    private var orderViewModels: [DrinksItemViewModel] = [DrinksItemViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    init(_ apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
        
        orderViewModels = [ DrinksItemViewModel(price: 200, image: UIImage(named: "sesame")!),
                            DrinksItemViewModel(price: 150, image: UIImage(named: "latte")!),
                            DrinksItemViewModel(price: 160, image: UIImage(named: "plumWine")!),
                            DrinksItemViewModel(price: 180, image: UIImage(named: "teaGin")!),
                            DrinksItemViewModel(price: 65, image: UIImage(named: "tea")!) ]
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
    
    func sendOrder() {
        let order = Client(list: nil,
                           gender: gender,
                           sesame: getCellViewModel(at: 0).counter,
                           latte: getCellViewModel(at: 1).counter,
                           plumWine: getCellViewModel(at: 2).counter,
                           teaGin: getCellViewModel(at: 3).counter,
                           tea: getCellViewModel(at: 4).counter,
                           amount: getTotalAmount())
        
//        apiManager.createData(with: order) { (success) in
//            if success {
//                self.showSuccess?()
//            }
//        }
        
        apiManager.request(Airtable.CreateRecords(order: order))
            .subscribe { (result) in
                debug(result)
                self.showSuccess?()
            } onError: { (error) in
                if let error = error as? MoyaError, let errorMessage = try? error.response?.mapJSON() {
                    print(errorMessage)
                }
            }
            .disposed(by: bag)
        
    }
    
    func getTotalAmount() -> Int {
        var amount = 0
        orderViewModels.forEach { (vm) in
            amount += vm.amount
        }
        return amount
    }
    
    func setGenderType(at index: Int) {
        switch index {
        case 1:
            gender = .female
        case 2:
            gender = .group
        default:
            gender = .male
        }
    }
    
    func resetCounter() {
        orderViewModels.forEach { (vm) in
            vm.counter = 0
        }
        self.reloadTableView?()
    }
}


