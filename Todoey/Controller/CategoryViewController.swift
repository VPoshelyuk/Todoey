//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Slava Pashaliuk on 4/3/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller doesn't exist.")}
        let app = UINavigationBarAppearance()
        app.backgroundColor = .none
        navBar.scrollEdgeAppearance = app
    }
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            
            guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
            
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        return cell
    }
    
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    // MARK: - Data manipulation methods
    func save(category: Category) {
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error saving category. \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
           do {
               try self.realm.write {
                   self.realm.delete(categoryForDeletion.items)
                   self.realm.delete(categoryForDeletion)
               }
           }catch{
               print("Error deleting category, \(error)")
           }
        }
    }
    
    // MARK: - Add new Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
           var tfInput = UITextField()
           
           let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
           let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
               let newCategory = Category()
               newCategory.name = tfInput.text!
               
               self.save(category: newCategory)
           }
           alert.addTextField { (alertTextField) in
               alertTextField.placeholder = "Create New Category"
               tfInput = alertTextField
           }
           
           alert.addAction(action)
           present(alert, animated: true, completion: nil)
    }
    
}

