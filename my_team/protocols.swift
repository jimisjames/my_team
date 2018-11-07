//
//  protocols.swift
//  my_team
//
//  Created by Jim Lambert on 11/6/18.
//  Copyright © 2018 Jim Lambert. All rights reserved.
//

import UIKit

protocol FormDelegate: class {
    func cancelButton()
    func saveButton(newPlayer: String)
    func save(newPlayer: String, indexPath: NSIndexPath)
}

