//
//  PickerHelper.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 28/09/22.
//

import Foundation
import UIKit
import CoreData
protocol PickerViewDelegate:AnyObject{
    func cancelBtnTapped(textField:UITextField)
    func doneBtnTapped(title:String?,textField:UITextField)
    
}
class PickerHelper:UIPickerView, UIPickerViewDelegate,UIPickerViewDataSource {
    var arrObj = [NSManagedObject]()
    var txtField : UITextField!
    weak  var delegatePicker:PickerViewDelegate?
    convenience init(arrObj:[NSManagedObject], textField :UITextField ) {
        self.init()
        self.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.height - 200, width: UIScreen.main.bounds.width, height: 200)
        self.backgroundColor = .systemBackground
        self.showsSelectionIndicator = true
        self.delegate = self
        self.dataSource = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action:  #selector(PickerHelper.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(PickerHelper.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputView = self
        textField.inputAccessoryView = toolBar
        txtField = textField
        self.arrObj = arrObj
        
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
     public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
         return self.arrObj[row].value(forKey: "name") as? String ?? ""
    }
    func selectRowAtIndx(row: Int){
         self.selectRow(row, inComponent: 0, animated: false)
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.arrObj.count
        
    }
    
    
    
   
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
   @objc func donePicker(){
    if let field = txtField{
        field.resignFirstResponder()
        if let delegate =   self.delegatePicker{
            
            let row = self.selectedRow(inComponent: 0)
            if self.arrObj.count > 0{
                delegate.doneBtnTapped(title: self.arrObj[row].value(forKey: "name") as? String, textField: txtField)
            }
            
        }
    }
    }
  @objc  func cancelPicker(){
    if let field = txtField{
        field.resignFirstResponder()
        if let delegate =   self.delegatePicker{
            delegate.cancelBtnTapped(textField: txtField)
        }
    }
    }
}
