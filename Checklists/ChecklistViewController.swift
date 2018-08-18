//
//  ViewController.swift
//  Checklists
//
//  Created by Esteban Trevino on 8/17/18.
//  Copyright © 2018 Esteban Trevino. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    //array of checklistItems
    var items: [ChecklistItem]
    
  
    
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
    
        
        let row0Item = ChecklistItem()
        row0Item.text = "Walk the dog"
        row0Item.checkState = false
        items.append(row0Item)
        
        let row1Item = ChecklistItem()
        row1Item.text = "Brush Teeth"
        row1Item.checkState = false
        items.append(row1Item)
        
        let row2Item = ChecklistItem()
        row2Item.text = "Learn IOS development"
        row2Item.checkState = false
        items.append(row2Item)
        
        let row3Item = ChecklistItem()
        row3Item.text = "Soccer Practice"
        row3Item.checkState = false
        items.append(row3Item)
        
        let row4Item = ChecklistItem()
        row4Item.text = "Eat ice cream"
        row4Item.checkState = false
        items.append(row4Item)
        
        let row5Item = ChecklistItem()
        row5Item.text = "git gud"
        row5Item.checkState = false
        items.append(row5Item)
        
        let row6Item = ChecklistItem()
        row6Item.text = "test item 1"
        row6Item.checkState = false
        items.append(row6Item)
        
        let row7Item = ChecklistItem()
        row7Item.text = "test item 2"
        row7Item.checkState = false
        items.append(row7Item)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            
            let item = items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmark(for: cell, with: item)

        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
       
        
        configureCheckmark(for: cell, with: item)
        configureLabelText(for: cell, with: item)
        
        return cell
    }
    
    func configureLabelText(for cell: UITableViewCell, with item: ChecklistItem){
         let label = cell.viewWithTag(1000) as! UILabel
         label.text = item.text
        
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem){

        if item.checkState {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}


