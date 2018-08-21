//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Esteban Trevino on 8/18/18.
//  Copyright © 2018 Esteban Trevino. All rights reserved.
//

import UIKit

protocol ItemDetailVDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailV)
    func itemDetailViewController(_ controller: ItemDetailV, didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailV, didFinishEditing item: ChecklistItem)
}

class ItemDetailV: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var textfield: UITextField!
    var itemToEdit: ChecklistItem?
  
    weak var delegate: ItemDetailVDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
            textfield.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textfield.text!
        let stringRange = Range(range, in: oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textfield.becomeFirstResponder()
    }
    

    
    @IBAction func cancel(){
        navigationController?.popViewController(animated: true)
        delegate?.itemDetailViewControllerDidCancel(self)
        
    }
    
    @IBAction func done(){
        if let itemToEdit = itemToEdit{
            itemToEdit.text = textfield.text!
            delegate?.itemDetailViewController(self, didFinishEditing: itemToEdit)
        } else {
            let item = ChecklistItem()
            item.text = textfield.text!
            item.checkState = false
            delegate?.itemDetailViewController(self, didFinishAdding: item )
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}
