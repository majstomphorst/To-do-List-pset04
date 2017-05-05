//
//  ViewController.swift
//  To do List pset04
//
//  Created by Maxim Stomphorst on 02/05/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    //MARK: properties
    @IBOutlet weak var toDoTableView: UITableView!
    
    // store the concent of the database only the "todoText" field
    var concentOfDatabase = [String]()
    
    override func viewDidAppear(_ animated: Bool) {
        // read database "todoText" field
        concentOfDatabase = Database.sharedinstance.readDatabase()
        
        // update the data
        self.toDoTableView.reloadData()
    }
    
    //MARK: tableView
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return concentOfDatabase.count
    }
    
    // content of cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoUITableViewCell
        
        // get database info if a item is done on todo (true/false)
        let bools = Database.sharedinstance.readCheckDatabase()
        
        // if a item is done make background green else red
        if bools[indexPath.row] {
            cell.toDoItem.backgroundColor = UIColor.green
        } else {
            cell.toDoItem.backgroundColor = UIColor.red
        }
        
        // display text
        cell.toDoItem.text = concentOfDatabase[indexPath.row]
        
        // return cell content and properties
        return cell
    }
    
    //MARK: actions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // switches the items bool value (done / todo)
        Database.sharedinstance.updateDoneDatabase(text: concentOfDatabase[indexPath.row])
        
        // update's the table
        self.toDoTableView.reloadData()
    }
    
    // checking if item may be edited always true
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // handle delete (by removing the data from the database and updating the tableview)
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            Database.sharedinstance.dropRowFromDatabase(text: concentOfDatabase[indexPath.row])
        }
        
        concentOfDatabase = Database.sharedinstance.readDatabase()
        self.toDoTableView.reloadData()
    }
    

}

 
