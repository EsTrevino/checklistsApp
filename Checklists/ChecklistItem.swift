//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Esteban Trevino on 8/18/18.
//  Copyright © 2018 Esteban Trevino. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    var text = ""
    var checkState = false
    
    func toggleChecked(){
        checkState = !checkState
    }
}
