//
//  ExpenseViewModel.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 25/09/22.
//

import Foundation
import CoreData
import UIKit

class ExpenseViewModel {
    // MARK: Array of type managed objects
    var model : [NSManagedObject]?
    var monthModel : [NSManagedObject]?
    
    // TODO: confirm this delegate from adapting view controller
    var delegate :ExpenseAddDelegate?
    
    //MARK: method to fetch all saved expense core data
    func getExpense() {
        let objects = CoredataHelper.instance.getvalue()
        model = objects
    }
    
    //MARK: method to fetch expense based on date
    func getExpenseBydate(date:String, month:String) {
        let objects = CoredataHelper.instance.getExpenseByDate(date: date)
        model = objects
        let monthData = CoredataHelper.instance.getExpenseByMonth(month: month)
        monthModel = monthData
    }
    
    //MARK: method to save the expense in core data
    func saveExpense(vc:UIViewController,name:String,amount:Double,date:String) {
        
        //MARK: context instance
        let managedContext = CoredataHelper.instance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Expense", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKeyPath: "name")
        person.setValue(date, forKeyPath: "date")
        person.setValue(amount, forKeyPath: "price")
        person.setValue(String(Date().millisecondsSince1970), forKey: "time")
        do {
            try managedContext.save()
            ShowDeadAlertwithMessage(vc: vc, message: "Expense Added!")
            delegate?.onExpenseAdd(status: true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            delegate?.onExpenseAdd(status: false)
        }
    }
    
    //MARK: method to delete selected object
    func deleteExpense(obj:NSManagedObject)-> Bool {
        let status = CoredataHelper.instance.deleteData(obj: obj)
        return status
    }
    
}
