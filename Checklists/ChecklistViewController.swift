//
//  ViewController.swift
//  Checklists
//
//  Created by Esteban Trevino on 8/17/18.
//  Copyright © 2018 Esteban Trevino. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailVDelegate {
    
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailV) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailV, didFinishEditing item: ChecklistItem) {
        if let index = items.index(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureLabelText(for: cell, with: item)
                
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailV, didFinishAdding item: ChecklistItem) {
         let newRowIndex = items.count
       
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
  
    
    //array of checklistItems
    var items: [ChecklistItem]

    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
    
//        let row0Item = ChecklistItem()
//        row0Item.text = "Walk the dog"
//        row0Item.checkState = false
//        items.append(row0Item)
//
//        let row1Item = ChecklistItem()
//        row1Item.text = "Brush Teeth"
//        row1Item.checkState = false
//        items.append(row1Item)
//
//        let row2Item = ChecklistItem()
//        row2Item.text = "Learn IOS development"
//        row2Item.checkState = false
//        items.append(row2Item)
//
//        let row3Item = ChecklistItem()
//        row3Item.text = "Soccer Practice"
//        row3Item.checkState = false
//        items.append(row3Item)
//
//        let row4Item = ChecklistItem()
//        row4Item.text = "Eat ice cream"
//        row4Item.checkState = false
//        items.append(row4Item)
//
//        let row5Item = ChecklistItem()
//        row5Item.text = "git gud"
//        row5Item.checkState = false
//        items.append(row5Item)
//
//        let row6Item = ChecklistItem()
//        row6Item.text = "test item 1"
//        row6Item.checkState = false
//        items.append(row6Item)
//
//        let row7Item = ChecklistItem()
//        row7Item.text = "test item 2"
//        row7Item.checkState = false
//        items.append(row7Item)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @IBAction func addItem(){
        let titles = ["title 1", "title 2", "title 3", "title 4", "title 5"]
        let randomNumber = arc4random_uniform(UInt32(titles.count))
        let title = titles[Int(randomNumber)]
        
        print("added item")
        //1) make actual checklist item
        let item = ChecklistItem()
            //-create values for item
            item.checkState = true
            item.text = title
        //2) add it to the array
        items.append(item)
        //3) insert it into the table
            //-determine where to insert it in table
        let newIndexRow = items.count
            //want it to be the last item
                //to do this get number of items in the table
                //items counted from zero and up
        let indexPath = IndexPath(row: newIndexRow - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailV
           controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func configureLabelText(for cell: UITableViewCell, with item: ChecklistItem){
         let label = cell.viewWithTag(1000) as! UILabel
         label.text = item.text
        
    }
    
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem){
        let label = cell.viewWithTag(1001) as! UILabel

        if item.checkState {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
}


