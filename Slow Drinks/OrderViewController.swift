//
//  ViewController.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/13.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var confirmBtn: UIButton!
    
    lazy var viewModel: OrderViewModel = {
        return OrderViewModel()
    }()
    
    var amount: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.amountLabel.text = "總計：\(self.amount)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        registerCells()
        bindViewModel()
    }
    
    func registerCells() {
        tableview.register(UINib(nibName: "DrinksItemCell", bundle: nil), forCellReuseIdentifier: DrinksItemCell.identifier)
    }
    
    
    // MARK: - Layout
    
    func setupUI() {
        tableview.allowsSelection = false
        
        confirmBtn.roundCorner(radius: confirmBtn.frame.height/2)
    }
    
    
    // MARK: - View Model
    func bindViewModel() {
        viewModel.reloadTableView = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
        }
        
        viewModel.handleError = { [weak self] (errorCode, errorMessage) in
            DispatchQueue.main.async {
//                self?.hideLoading()
//                self?.delegate?.showError(errorCode, errorMessage)
            }
        }
    }
    
    
    // MARK: - Button click
    
    @IBAction func confirmBtnPressed(_ sender: UIButton) {
        viewModel.createData()
    }
}


// MARK: - UITableViewDelegate

extension OrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


// MARK: - UITableViewDataSource

extension OrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = viewModel.getCellViewModel(at: indexPath.row)
        
        cellVM.updateAmount = { (count) in
            self.amount = self.amount + count
        }
        
        guard let cell = tableview.dequeueReusableCell(withIdentifier: DrinksItemCell.identifier, for: indexPath) as? DrinksItemCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.viewModel = cellVM
        return cell
    }
}
