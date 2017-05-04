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
    
    static let sharedinstance = Database()
    
    //MARK: SQL Database
    private var  connection: Connection?
    
    private let todoTable = Table("todoTable")
    private let id = Expression<Int64>("id")
    private let check = Expression<Bool>("check")
    private let todoText = Expression<String>("todoText")
    
    private init() {
        // creating the database
        setupDatabase()
    }
    
    // sets up the database and creats the table in the database (it call the function createTable
    func setupDatabase() {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        // print(path)
        
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
        }  catch {
            print("faild to create table\(error)")
        }
    }
    
    func rideDatabase(text: String, completed: Bool = false) {
        let insert = todoTable.insert(todoText <- text, check <- completed)
        
        do {
            try connection!.run(insert)
        } catch {
            print("database insertion failed\(error)")
        }
    }
    
    func readDatabase() -> [String] {
        
        var concentOfDatabase = [String]()
        
        do {
            for item in try connection!.prepare(todoTable) {
                concentOfDatabase.append(item[todoText])
                
                // concentOfDatabase.append("id: \(item[id]),done: \(item[check]) ,name: \(item[todoText])")
            }
            
        } catch {
            print("read database failed \(error)")
        }
        return concentOfDatabase
    }
    
    func deleteFromDatabase() {
        // let insert = todoTable.delete()
    }
    
    
}
