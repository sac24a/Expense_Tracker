//
//  ExpenseCell.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 15/09/22.
//

import UIKit

class ExpenseCell: UITableViewCell {
    
    @IBOutlet weak var exxpenseTitile: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
}
