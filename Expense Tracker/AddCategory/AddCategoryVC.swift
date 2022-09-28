//
//  AddCategoryVC.swift
//  Expense Tracker
//
//  Created by ITRENTALINDIA on 28/09/22.
//

import UIKit

class AddCategoryVC: UIViewController, CategoryDelegate,CategoryAlertDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    var viewModel = CategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        viewModel.delegate = self
        viewModel.getCategory()
        
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addBtn(_ sender: Any) {
        AlertManager.delegate = self
        AlertManager.AddCategoryAlert(vc: self, message: "Add Category")
    }
    func onCategoryAdd(status: Bool) {
        viewModel.getCategory()
        self.tblView.reloadData()
    }
    func getCategoryName(category: String) {
        print(category)
        viewModel.saveCategory(vc: self, name: category)
    }
    
}
extension AddCategoryVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")
        cell?.textLabel?.text = viewModel.model?[indexPath.row].value(forKey: "name") as? String
        return cell!
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // deleting the record from the core data
            let status = viewModel.deleteCategory(name: (viewModel.model?[indexPath.row])!)
            if status {                                
                viewModel.model?.remove(at: indexPath.row)
                tableView.reloadData()
            }
            else {
                ShowDeadAlertwithMessage(vc: self, message: "Unable to delete")
            }
            
            
        }
    }
    
}
