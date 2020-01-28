//
//  TableViewController.swift
//  Todo
//
//  Created by Anuj Doshi on 27/01/20.
//  Copyright © 2020 Anuj Doshi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = Item()
        newItem.title = "Find Milk"
        itemArray.append(newItem)
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]
        {
                itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todo",for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        

        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray,forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action,index in
//
//        }
//        delete.backgroundColor = .red
//        return [delete]
//    }
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let info = UIContextualAction(style: .normal, title: "Info") { (ac:UIContextualAction, view:UIView, sucess:(Bool) -> Void) in
            sucess(true)
        }
        info.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [info])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (ac:UIContextualAction, view:UIView, sucess:(Bool) -> Void) in
            sucess(true)

        }
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}
