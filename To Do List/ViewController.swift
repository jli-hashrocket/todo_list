//
//  ViewController.swift
//  To Do List
//
//  Created by Jeff Li on 1/4/17.
//  Copyright © 2017 Jeff Li. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tField:UITextField!
    var items:[Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = self.items[indexPath.row]
        cell.textLabel!.text = item.title
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        alertPopup()
    }
    
    func configurationTextField(textField: UITextField) {
        textField.placeholder = "Enter new item"
        self.tField = textField
    }
    
    func saveNewItem() {
        print("Item Saved!")
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as! Item
        
        item.title = tField.text
        
        do {
            try context.save()
        } catch _ {
            
        }
        let request:NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        var results:[AnyObject]?
        
        do {
            results = try context.fetch(request)
        } catch _ {
            results = nil
        }
        
        if results != nil {
            self.items = results as! [Item]
        }
        
        self.tableView.reloadData()
    }
    
    func alertPopup(){
        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            alert.dismiss(animated: true, completion: nil)
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default){
            UIAlertAction in
            self.saveNewItem()
        }
        
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}

