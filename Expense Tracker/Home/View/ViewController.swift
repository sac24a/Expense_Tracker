//
//  ViewController.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 15/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    // MARK: View model instance
    var viewModel = ExpenseViewModel()
    
    // MARK: Date Picker instance to show date picker in action sheet
    var dateHelper = DatePickerHelper()
    
    @IBOutlet weak var totalExpense: UILabel!
    @IBOutlet weak var monthlyExpense: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Registering the table cell with table view
        let nib = UINib(nibName: "ExpenseCell", bundle: .main)
        tblView.register(nib, forCellReuseIdentifier: "ExpenseCell")
        tblView.estimatedRowHeight = UITableView.automaticDimension
        
        // MARK:  Disabling the multiple row selection
        tblView.allowsMultipleSelectionDuringEditing = false
        
        // MARK:  Confirming to date picker protocol on done button click
        dateHelper.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK:  calling function to get saved expense today
        viewModel.getExpenseBydate(date: Date().currentDate, month: Date().currentMonth)
        
        guard let _ = viewModel.model?.count else {return}
        tblView.reloadData()
        
        // MARK:  get total expense value
        calculateTotalExpense()
    }
    
    // MARK:  Calender button click action, expense by date
    @IBAction func getExpenseByDate(_ sender: Any) {
        
        // MARK:  calling action sheet date picker
        dateHelper.ShowDatePicker(vc: self)
        
    }
    
    // MARK:  calculating the sum of dispayed expense
    func calculateTotalExpense(){
        
        if viewModel.model?.count != nil && viewModel.model?.count != 0 {
            var sum = 0.00
            for value in viewModel.model! {
                sum += value.value(forKey: "price") as! Double
            }
            totalExpense.text = "₹\(sum)"
        }
        else {
            totalExpense.text = "₹\(0.00)"
            // MARK:  Global function to show alert with no action
            ShowDeadAlertwithMessage(vc: self, message: "No expense to show, Please add expense")
        }
        if viewModel.monthModel?.count != nil && viewModel.monthModel?.count != 0 {
            var sum = 0.00
            for value in viewModel.monthModel! {
                sum += value.value(forKey: "price") as! Double
            }
            monthlyExpense.text = "₹\(sum)"
        }
        else {
            monthlyExpense.text = "₹\(0.00)"
        }
    }
    
    // MARK:  Home button click action
    @IBAction func homeBtnClicked(_ sender: Any) {
    }
    
    // MARK:  Add expense click action
    @IBAction func plusBtnClicked(_ sender: Any) {
        
        // MARK:  Navigating to Add expense view controller
        let story = UIStoryboard(name: "Main", bundle: .main)
        let vc = story.instantiateViewController(withIdentifier: "AddExpenseVC") as! AddExpenseVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    // MARK: Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model?.count ?? 0
    }
    // MARK: Cell for table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK:  reusing cell to display data
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell") as! ExpenseCell
        cell.exxpenseTitile.text = viewModel.model?[indexPath.row].value(forKey: "name") as? String
        cell.dateLbl.text = viewModel.model?[indexPath.row].value(forKey: "date") as? String
        cell.priceLbl.text = "₹\((viewModel.model?[indexPath.row].value(forKey: "price") as? Double)!)"
        cell.selectionStyle = .none
        return cell
    }
    // MARK:  Adjusting the row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    // MARK:  table view cell swipe left delete style
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // deleting the record from the core data
            let status = viewModel.deleteExpense(obj: (viewModel.model?[indexPath.row])!)
            if status {
                // deleting the record from the model
                let pos = viewModel.monthModel?.firstIndex(of: (viewModel.model?[indexPath.row])!)
                viewModel.monthModel?.remove(at: pos!)
                viewModel.model?.remove(at: indexPath.row)                
                tableView.reloadData()
                calculateTotalExpense()
            }
            else {
                ShowDeadAlertwithMessage(vc: self, message: "Unable to delete")
            }
            
            
        }
    }
}
// MARK: Protocol method
extension ViewController: ActionSheetDatePickerDelegate {
    func onDoneClicked(date: String, month: String) {
        viewModel.getExpenseBydate(date: date, month: month)
        tblView.reloadData()
        calculateTotalExpense()
    }
    
    // MARK: Get date on done button
    func onDoneClicked(date: String) {
        
    }
}


