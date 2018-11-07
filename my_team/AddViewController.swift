//
//  AddViewController.swift
//  my_team
//
//  Created by Jim Lambert on 11/6/18.
//  Copyright © 2018 Jim Lambert. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    weak var delegate: FormDelegate?

    @IBOutlet weak var newPlayer: UITextField!
    var currentPlayer: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        newPlayer.text = currentPlayer
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.cancelButton()
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        delegate?.saveButton(newPlayer: newPlayer.text!)
    }
    
}
