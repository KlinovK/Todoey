//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Константин Клинов on 4/13/18.
//  Copyright © 2018 Константин Клинов. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
loadCategories()
       
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathsForSelectedRows?.first {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoye Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
           
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            self.saveCategories()
            
      
            
        }
        
        
        alert.addAction(action)

        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: TableView
    
    func saveCategories(){
        do {
            try context.save()
            
        } catch {
            print("\(error)")
        }
        self.tableView.reloadData()
    }
   
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        
        
        do {
            categories = try context.fetch(request)
            
        }
        catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
}