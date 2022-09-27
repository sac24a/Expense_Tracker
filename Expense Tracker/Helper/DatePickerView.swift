

import Foundation
import UIKit

//MARK: Custom date picker for AddExpenseVC
protocol DatePickerViewDelegate:class{
    func cancelDateBtnTapped(textField:UITextField)
    func doneBtnTapped(date:String,textField:UITextField)
}

open class DatePickerView	: UIDatePicker {
    
    var textFieldDate: UITextField!
    weak var delegate:DatePickerViewDelegate?
    convenience init(textField:UITextField, lbldate:String){
        self.init()
        
        self.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.height - 200, width: UIScreen.main.bounds.width, height: 200)
        self.backgroundColor = .white
       
        self.datePickerMode = .date
    
        if #available(iOS 13.4, *) {
            self.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
       
//        var birthdayDate18Year :Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
//        var birthdayDate :Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
//        if lbldate != ""{
//            let dateFormater = DateFormatter()
//            dateFormater.dateFormat = "dd MMM yyyy"
//            birthdayDate = dateFormater.date(from: lbldate)!
//        }
//        self.date = birthdayDate
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action:  #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputView = self
        textField.inputAccessoryView = toolBar
        textFieldDate = textField
    }
    
   
   
    @objc func donePicker(){
        if let field = textFieldDate{
            field.resignFirstResponder()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy" //"MM/dd/yyyy"
            let date = formatter.string(from: self.date)
            if let delegate =   self.delegate{
                delegate.doneBtnTapped(date: date, textField: textFieldDate)
            }
            
        }
    }
    @objc  func cancelPicker(){
        if let field = textFieldDate{
            field.resignFirstResponder()
            if let delegate =   self.delegate{
                delegate.cancelDateBtnTapped(textField: textFieldDate)
            }
            
        }
        
    }
}
