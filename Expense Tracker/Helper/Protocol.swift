//
//  Protocol.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 26/09/22.
//

import Foundation
protocol ButtonDelegate : AnyObject{
    func clickOnButtonListener()
}
protocol ExpenseAddDelegate{
    func onExpenseAdd(status:Bool)
}
protocol ActionSheetDatePickerDelegate {
    func onDoneClicked(date:String,month:String)
}
protocol CategoryDelegate {
    func onCategoryAdd(status:Bool)
}
protocol CategoryAlertDelegate {
    func getCategoryName(category:String)
}
