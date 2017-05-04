//
//  Database.swift
//  To do List pset04
//
//  Created by Maxim Stomphorst on 04/05/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import Foundation
import SQLite

class Database {
    
    //MARK: SQL Database
    var connection: Connection?
    
    let todoTable = Table("todoTable")
    let id = Expression<Int64>("id")
    let check = Expression<Bool>("check")
    let todoText = Expression<String>("todoText")
    
    init() {
        // creating the database
        setupDatabase()
    }
    
    // sets up the database and creats the table in the database (it call the function createTable
    func setupDatabase() {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print(path)
        
        do {
            connection = try Connection("\(path)/db.sqlite3")
            createTable()
        } catch {
            print("Cant connect to database:\(error)")
        }
    }
    
    // creats the tabels in a database file
    func createTable() {
        do {
            try connection!.run(todoTable.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(check)
                t.column(todoText, unique: true)
            } )
        } catch {
            print("faild to create table\(error)")
        }
    }
    
    func saveToDatabase(text: String, completed: Bool = false) {
        let insert = todoTable.insert(todoText <- text, check <- completed)
        
        do {
            let rowId = try connection!.run(insert)
            print(rowId)
        } catch {
            print("database insertion failed\(error)")
            
        }
        
    }
    
    
}