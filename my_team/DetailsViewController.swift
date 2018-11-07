//
//  DetailsViewController.swift
//  my_team
//
//  Created by Jim Lambert on 11/6/18.
//  Copyright © 2018 Jim Lambert. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, FormDelegate {
    
    weak var delegate: FormDelegate?
    var indexPath: NSIndexPath?

    @IBOutlet weak var playerLabel: UILabel!
    
    var currentPlayer: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        playerLabel.text = currentPlayer
        hitApi()
    }
    
    struct myObject: Decodable {
        var name: String
        var gender: String
        var culture: String
        var titles: [String]
    }
    
    func hitApi(){
        
        let apiKey = "926ba066-11b8-4b56-a740-4c06ce"
        let password = "Jimiscool3#"
        let loginString = String(format: "%@:%@", apiKey, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        var url = URLRequest(url: URL(string: "https://api.mysportsfeeds.com/v2.0/pull/nhl/players.json")!)
//        url.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        url.setValue("Basic 926ba066-11b8-4b56-a740-4c06ce:Jimiscool3#", forHTTPHeaderField: "Authorization")
        url.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        url.setValue("my_team", forHTTPHeaderField: "User-Agent")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                print(data!)
                do{
                    let decodedData = try JSONDecoder().decode(myObject.self, from: data!)
                    print(decodedData)
                } catch {
                    print("Error! \(error)")
                }
            } else {
                print("Error! \(error!)")
            }
        }
        task.resume()
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        delegate?.cancelButton()
    }
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "edit", sender: self)
    }
    
    func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func saveButton(newPlayer: String) {
        if newPlayer.count > 0 {
            playerLabel.text = newPlayer
            delegate?.save(newPlayer: newPlayer, indexPath: indexPath!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            let navCon = segue.destination as! UINavigationController
            let destination = navCon.topViewController as! AddViewController
            destination.delegate = self
            destination.currentPlayer = currentPlayer
        }
    }
    
    func save(newPlayer: String, indexPath: NSIndexPath){
        print(newPlayer)
    }

}
