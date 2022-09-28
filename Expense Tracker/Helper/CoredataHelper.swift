//
//  CoredataHelper.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 25/09/22.
//

import Foundation
import CoreData
import UIKit
struct CoredataHelper {
    static var instance = CoredataHelper()
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Expense_Tracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK: Save data
    func saveContext (vc:UIViewController, name:String,amount:Double,date:String) {
        let context = CoredataHelper.instance.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                ShowDeadAlertwithMessage(vc: vc, message: "Expense Added!")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    //MARK: Retrieve all data
    func getvalue() -> [NSManagedObject] {
        var people: [NSManagedObject] = []
        let context = CoredataHelper.instance.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Expense")
        do {
            people = try context.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        return people
    }
    
    //MARK: Retrieve data by date
    func getExpenseByDate(date:String) -> [NSManagedObject] {
        var people: [NSManagedObject] = []
        let context = CoredataHelper.instance.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Expense")
        fetchRequest.predicate = NSPredicate(format: "date = %@", date)
        do {
            people = try context.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        return people
    }
    
    //MARK: Retrieve data by month
    func getExpenseByMonth(month:String) -> [NSManagedObject] {
        var people: [NSManagedObject] = []
        let context = CoredataHelper.instance.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Expense")
        fetchRequest.predicate = NSPredicate(format: "date contains %@", month)
        do {
            people = try context.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        return people
    }
    
    //MARK: delete selected data 
    func deleteData(obj:NSManagedObject)->Bool {
        let context = CoredataHelper.instance.persistentContainer.viewContext
        context.delete(obj)

        do {
            try context.save() // <- remember to put this :)
            return true
        } catch {
            return false            
        }
    }
}
