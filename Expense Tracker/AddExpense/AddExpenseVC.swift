//
//  AddExpenseVC.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 26/09/22.
//

import UIKit

class AddExpenseVC: UIViewController {
    // MARK: Text field outlets
    @IBOutlet weak var expenseName: UITextField!
    @IBOutlet weak var expenseAmount: UITextField!
    @IBOutlet weak var expenseDate: UITextField!
    var viewModel = ExpenseViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Confirming text field delegate
        expenseDate.delegate = self
        expenseName.delegate = self
        expenseAmount.delegate = self
        viewModel.delegate = self
    }

    @IBAction func addBtn(_ sender: Any) {
        //MARK: checking nil or empty value
        if expenseName.text == "" {
            print(String(Date().millisecondsSince1970))
            ShowDeadAlertwithMessage(vc: self, message: "Enter Expense Name")
            
        }
        else if expenseAmount.text == "" {
            ShowDeadAlertwithMessage(vc: self, message: "Enter Expense Amount")
        }
        else if expenseDate.text == "" {
            ShowDeadAlertwithMessage(vc: self, message: "Select Expense Date")
        }
        else {
            //MARK: save data
            viewModel.saveExpense(vc: self, name: expenseName.text ?? "", amount: Double(expenseAmount.text ?? "0.00")!, date: expenseDate.text ?? "")   
        }
        
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension AddExpenseVC : UITextFieldDelegate,DatePickerViewDelegate {
    func cancelDateBtnTapped(textField: UITextField) {
        textField.text = ""
    }
    
    func doneBtnTapped(date: String, textField: UITextField) {
        print(date)
        textField.text = date
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == expenseDate {
            //MARK: DatePicker
            let datePicker   = DatePickerView.init(textField: textField, lbldate: expenseDate.text ?? "")
            datePicker.delegate = self
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
extension AddExpenseVC : ExpenseAddDelegate {
    //MARK: delegate method Adding expense
    func onExpenseAdd(status: Bool) {
        if status {
            expenseName.text = ""
            expenseDate.text = ""
            expenseAmount.text = ""
            ShowDeadAlertwithMessage(vc: self, message: "Expense Added!")
        }
        else {
            ShowDeadAlertwithMessage(vc: self, message: "Expense not saved!")
        }
    }
}
