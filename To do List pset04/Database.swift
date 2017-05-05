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
    
    // creating Database properties
    private let todoTable = Table("todoTable")
    private let id = Expression<Int64>("id")
    private let check = Expression<Bool>("check")
    private let todoText = Expression<String>("todoText")
    
    private init() {
        // creating the database
        setupDatabase()
        setup()
    }
    
    // sets up the database and creats the table in the database (it call the function createTable)
    func setupDatabase() {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
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
    
    func setup() {
        rideDatabase(text: "press the plus icon to add a todo")
        rideDatabase(text: "Press me to change statu done/ todo")
        rideDatabase(text: "red is todo. Like me!")
        rideDatabase(text: "green is done. Like me!",completed: true)
    }
    
    // inserts a row in the database
    func rideDatabase(text: String, completed: Bool = false) {
        let insert = todoTable.insert(todoText <- text, check <- completed)
        
        do {
            try connection!.run(insert)
        } catch {
            print("database insertion failed\(error)")
        }
    }
    
    func readCheckDatabase() -> [Bool] {
        var concentOfCheckDatabase = [Bool]()
        
        do {
            for item in try connection!.prepare(todoTable) {
                concentOfCheckDatabase.append(item[check])
            }
            
        } catch {
            print("read  (bool) database failed \(error)")
        }
        
        return concentOfCheckDatabase
    }
    
    
    
    func readDatabase() -> [String] {
        
        var concentOfDatabase = [String]()
        
        do {
            for item in try connection!.prepare(todoTable) {
                concentOfDatabase.append(item[todoText])
            }
            
        } catch {
            print("read database failed \(error)")
        }
        
        return concentOfDatabase
    }
    
    func updateDoneDatabase(text: String) {
        var checking = Int()
        
        let change = todoTable.filter(todoText == text && check == false)
        do {
            checking = try connection!.run(change.update(check <- true))
            
        } catch {
            print("update1 fout")
        }
        
        if checking == 0 {
            let change = todoTable.filter(todoText == text && check == true)
            do {
                checking = try connection!.run(change.update(check <- false))
            } catch {
                print("update2 fout")
            }
            
        }
    
    }
    
    func dropRowFromDatabase(text: String) {

        let dropRow = todoTable.filter(todoText == text)
        do {
            try connection!.run(dropRow.delete())
        } catch {
            print("error with deleting")
        }
    }
}
