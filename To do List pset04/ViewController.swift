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

    //MARK: SQL Database
    var database: Connection?
    
    let todoTable = Table("todoTable")
    let id = Expression<Int64>("id")
    let check = Expression<Bool>("check")
    let todoText = Expression<String>("todoText")
    
    let lst = ["Get millk", "Get honey", "Get chicken"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating the database and create the table's
        setupDatabase()

         
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //MARK: tableView
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lst.count
    }
    
    // content of cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoUITableViewCell
        
        cell.toDoItem.text = lst[indexPath.row]
        
        return cell
    }
    
    //MARK: actions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            print("delette")
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    //MARK: database functions
    
    // creating a empty database.sqlite3 file
    func setupDatabase() {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            database = try Connection("\(path)/db.sqlite3")
            
            createTable()
            
        } catch {
            print("Cant connect to database:\(error)")
        }
    }
    
    func createTable() {
        do {
            try database!.run(todoTable.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(check)
                t.column(todoText, unique: true)
            } )
        } catch {
            print("faild to create table\(error)")
        }
    }


}

 
