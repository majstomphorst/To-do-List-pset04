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
    
    // creating a key for userdefaults
    let keyText = "1"
    let keyboard = "2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let inputFieldText = UserDefaults.standard.value(forKey: keyText) {
            inputField.text = inputFieldText as? String
        }
        
        if let inputFieldText = UserDefaults.standard.value(forKey: keyboard) as? Bool{
            
            if inputFieldText {
                self.inputField.becomeFirstResponder()
                
            }
            
        }
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.label.text = ""
        UserDefaults.standard.set("", forKey: keyText)
        UserDefaults.standard.set(false, forKey: keyboard)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: actions
    @IBAction func saveButton(_ sender: Any) {
        
        // adding what's in the text field to the database
        Database.sharedinstance.rideDatabase(text: inputField.text!)
        
        // error handeling!
        
        // emptying the label
        self.label.text = ""
        UserDefaults.standard.set("", forKey: keyText)
        UserDefaults.standard.set(false, forKey: keyboard)
        // returing to previous viewController
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func inputFieldChanged(_ sender: UITextField) {
        UserDefaults.standard.set(inputField.text, forKey: keyText)
    }
    
    @IBAction func InputFieldBeginEdit(_ sender: UITextField) {
        UserDefaults.standard.set(true, forKey: keyboard)
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
