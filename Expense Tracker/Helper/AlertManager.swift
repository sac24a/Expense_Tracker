//
//  AlertManager.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 26/09/22.
//

import Foundation
import UIKit
class AlertManager {
    //MARK: class function to show alert
    static var delegate : CategoryAlertDelegate?
    class func showDeadAlertwithMessage(vc:UIViewController, message:String) {
        let alert = UIAlertController.init(title: "Expense Tracker", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    class func AddCategoryAlert(vc: UIViewController,message : String){
        let alert = UIAlertController.init(title: "Expense Tracker", message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter Category Name"
            textField.autocapitalizationType = .words
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(cancel)
        let add = UIAlertAction(title: "Add", style: .default) { UIAlertAction in
            let textField = alert.textFields![0] as UITextField
            delegate?.getCategoryName(category: textField.text!)
            
        }
        alert.addAction(add)
        vc.present(alert, animated: true)
    }
}

//MARK: Global function to show alert
func ShowDeadAlertwithMessage(vc:UIViewController, message:String) {
    let alert = UIAlertController.init(title: "Expense Tracker", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alert.addAction(action)
    vc.present(alert, animated: true)
}

