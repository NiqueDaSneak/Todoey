//
//  ViewController.swift
//  Todoey
//
//  Created by Clemmer, Dom on 6/2/18.
//  Copyright © 2018 niquedasneak. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Wash dishes", "Roll a joint", "Smoke a joint"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "toDoListArray") as? [String] {
            itemArray = items
        }
    }
    
    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todo Item", message: "Enter text below", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            // what will happen once the user clicks
            if textField.text == "" {
                print("fuck you!")
                self.present(alert, animated: true) {
                    print("Alert Showing!")
                }
                textField.placeholder = "ADD AN ITEM TO THE LIST"
            } else {
                self.itemArray.append(textField.text!)
                self.defaults.set(self.itemArray, forKey: "toDoListArray")
                self.tableView.reloadData()
                
            }
            
            
            
            
        }
        
        alert.addAction(action)
        
        alert.addTextField {
            (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Make another todo item"
        }
        
        present(alert, animated: true) {
            print("Alert Showing!")
        }
    }
    
}

