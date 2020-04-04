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

class CategoryViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        return cell
    }
    
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
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

