//
//  ViewController.swift
//  my_team
//
//  Created by Jim Lambert on 11/6/18.
//  Copyright © 2018 Jim Lambert. All rights reserved.
//

import UIKit
import CoreData

class MyTeamViewController: UITableViewController, FormDelegate {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var items = [Player]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        if items.count < 16 {
            performSegue(withIdentifier: "form", sender: self)
        } else {
            let alert = UIAlertController(title: "Too Many Players", message: "Only 16 Players Per Roster, Delete or change one of your existing Players", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proto", for: indexPath)
        cell.textLabel?.text = String(indexPath.row + 1) + ". " + items[indexPath.row].name!
        return cell
    }
    
    func fetchData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        do {
            let results = try managedObjectContext.fetch(request)
            items = results as! [Player]
        } catch {
            print("Error! \(error)")
        }
    }
    
    func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func saveButton(newPlayer: String) {
        if newPlayer.count > 0 {
            let playerObj = NSEntityDescription.insertNewObject(forEntityName: "Player", into: managedObjectContext) as! Player
            playerObj.name = newPlayer
            items.append(playerObj)
        }
        saveContext()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func save(newPlayer: String, indexPath: NSIndexPath){
        if newPlayer.count > 0 {
            let item = items[indexPath.row]
            item.name = newPlayer
            tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "form" {
            let navCon = segue.destination as! UINavigationController
            let destination = navCon.topViewController as! AddViewController
            destination.delegate = self
        } else if segue.identifier == "details" {
            let navCon = segue.destination as! UINavigationController
            let destination = navCon.topViewController as! DetailsViewController
            destination.delegate = self
            let indexPath = sender as! NSIndexPath
            destination.currentPlayer = items[indexPath.row].name
            destination.indexPath = indexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
}

