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
    
    var concentOfDatabase = [String]()
    
    override func viewDidAppear(_ animated: Bool) {
        concentOfDatabase = Database.sharedinstance.readDatabase()
        
        self.toDoTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: tableView
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return concentOfDatabase.count
    }
    
    // content of cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoUITableViewCell
        
        cell.toDoItem.text = concentOfDatabase[indexPath.row]
        
        return cell
    }
    
    //MARK: actions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you selected DidSelectRowAt\(indexPath.row)")
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



}

 
