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
        
        viewModel.showSuccess = { [weak self] () in
            DispatchQueue.main.async {
                self?.showSuccessMessage()
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
    
    
    @IBAction func genderPressed(_ sender: UISegmentedControl) {
        viewModel.setGenderType(at: sender.selectedSegmentIndex)
    }
    
    @IBAction func confirmBtnPressed(_ sender: UIButton) {
        viewModel.sendOrder()
    }
    
    
    // MARK: - privacy method
    
    func showSuccessMessage() {
        
        let alertController = UIAlertController(title: "新增成功！！", message: "test~~~~~~~~~", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "確定", style: .default, handler: { (action) in
            self.viewModel.resetCounter()
        }))
        self.present(alertController, animated: true, completion: nil)
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
        
        cellVM.updateAmount = { [weak self] () in
            self?.amount = self?.viewModel.getTotalAmount() ?? 0
        }
        
        guard let cell = tableview.dequeueReusableCell(withIdentifier: DrinksItemCell.identifier, for: indexPath) as? DrinksItemCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.viewModel = cellVM
        return cell
    }
}
