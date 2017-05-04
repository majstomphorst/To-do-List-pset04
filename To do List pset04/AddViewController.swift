//
//  AddViewController.swift
//  To do List pset04
//
//  Created by Maxim Stomphorst on 03/05/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import UIKit
import SQLite

class AddViewController: UIViewController {

    //MARK: outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    var database: Database?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database?.rideDatabase(text: "77")
        let concentOfDatabase = database?.readDatabase()
        print(concentOfDatabase!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: actions
    @IBAction func saveButton(_ sender: UIButton) {
        
        self.label.text = "clicked!"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
