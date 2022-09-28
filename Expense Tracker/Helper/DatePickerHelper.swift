//
//  DatePickerHelper.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 27/09/22.
//

import Foundation
import UIKit
class DatePickerHelper {
    
    //MARK: creating Date Picker progrmmatically
    var datePicker = UIDatePicker()
    
    //MARK: Protocol initialize
    var delegate : ActionSheetDatePickerDelegate?
    
    //MARK: Method to show date picker in action sheet
    func ShowDatePicker(vc:UIViewController) {
        
        //MARK: creating Actionsheet
        let alert = UIAlertController(title: "Choose date", message: "", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Done", style: .default) { UIAlertAction in
            
            //MARK: Date format 1 Jan 2022
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy" //"MM/dd/yyyy"
            let date = formatter.string(from: self.datePicker.date)
            
            //MARK: get month
            let newForm = DateFormatter()
            newForm.dateFormat = "MMM"
            let month = newForm.string(from: self.datePicker.date)
            
            //MARK: delegate on view controller
            self.delegate?.onDoneClicked(date: date, month: month)
        }
        alert.addAction(action)
        alert.view.addSubview(datePicker)
        //MARK: customizing date picker
        datePicker.date = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor,constant: 15).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor,constant: -50).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor,constant: 10).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor,constant: -10).isActive = true
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 350)
        alert.view.addConstraint(height)
        vc.present(alert, animated: true)
    }
}

