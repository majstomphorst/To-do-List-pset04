//
//  ToDoUITableViewCell.swift
//  To do List pset04
//
//  Created by Maxim Stomphorst on 03/05/2017.
//  Copyright © 2017 M.a.j©. All rights reserved.
//

import UIKit

class ToDoUITableViewCell: UITableViewCell {

    @IBOutlet weak var toDoItem: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
