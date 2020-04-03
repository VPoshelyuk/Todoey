//
//  ViewController.swift
//  Todoey
//
//  Created by Slava Pashaliuk on 4/2/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard

    var itemArray = [
        TableCell(title: "Find Mike"),
        TableCell(title: "Check"),
        TableCell(title: "Uo Mike", done: true),
        TableCell(title: "Suop"),
        TableCell(title: "Find Mike"),
        TableCell(title: "Check"),
        TableCell(title: "Uo Mike", done: true),
        TableCell(title: "Suop"),
        TableCell(title: "Find Mike"),
        TableCell(title: "Check"),
        TableCell(title: "Uo Mike", done: true),
        TableCell(title: "Suop"),
        TableCell(title: "Find Mike"),
        TableCell(title: "Check"),
        TableCell(title: "Uo Mike", done: true),
        TableCell(title: "Suop"),
        TableCell(title: "Find Mike"),
        TableCell(title: "Check"),
        TableCell(title: "Uo Mike", done: true),
        TableCell(title: "Suop"),
        TableCell(title: "Find Mike"),
        TableCell(title: "Check"),
        TableCell(title: "Uo Mike", done: true),
        TableCell(title: "Suop")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
        // Do any additional setup after loading the view.
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var tfInput = UITextField()

        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let safeText = tfInput.text {
                let newItem = TableCell(title: safeText)
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            tfInput = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

