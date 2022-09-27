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
    class func showDeadAlertwithMessage(vc:UIViewController, message:String) {
        let alert = UIAlertController.init(title: "Expense Tracker", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
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
