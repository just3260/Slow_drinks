//
//  DrinksItemCell.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/15.
//

import UIKit

class DrinksItemCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    static let identifier = "DrinksItemCell"
    
    var viewModel: DrinksItemViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateUI() {
        guard let vm = viewModel else {return}
        
        icon.image = vm.image
        price.text = "售價：\(vm.price)"
        counter.text = "\(vm.counter)"
        
        stepper.value = Double(vm.counter)
    }
    
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        guard let vm = viewModel else {return}
        
        vm.counter = Int(sender.value)
        counter.text = "\(vm.counter)"
    }
}
