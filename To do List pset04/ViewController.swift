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
    
    @IBOutlet weak var toDoTableView: UITableView!

    
    
    let lst = ["Get millk", "Get honey", "Get chicken"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lst.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoUITableViewCell
        
        cell.toDoItem.text = lst[indexPath.row]
        
        return cell
        
    }


}

 
