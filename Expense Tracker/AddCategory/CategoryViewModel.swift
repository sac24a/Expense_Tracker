//
//  CategoryViewModel.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 28/09/22.
//

import Foundation
import CoreData
import UIKit
struct CategoryViewModel {
    var model : [NSManagedObject]?
    var name : String?
    // TODO: confirm this delegate from adapting view controller
    var delegate :CategoryDelegate?
    
    func saveCategory(vc:UIViewController, name:String) {
        //MARK: context instance
        let managedContext = CoredataHelper.instance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKeyPath: "name")
        do {
            try managedContext.save()
            ShowDeadAlertwithMessage(vc: vc, message: "Category Added!")
            delegate?.onCategoryAdd(status: true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            delegate?.onCategoryAdd(status: false)
        }
    }
    func deleteCategory(name:NSManagedObject) -> Bool{
        let status = CoredataHelper.instance.deleteData(obj: name)
        return status
    }
    mutating func getCategory() {
        let objects = CoredataHelper.instance.getCategory()
        model = objects
    }
    
}
