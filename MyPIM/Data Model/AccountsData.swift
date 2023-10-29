/*
**********************************************************
*   Statement of Compliance with the Stated Honor Code   *
**********************************************************
I hereby declare on my honor and I affirm that
 
 (1) I have not given or received any unauthorized help on this assignment, and
 (2) All work is my own in this assignment.
 
I am hereby writing my name as my signature to declare that the above statements are true:
   
      Yuxuan Li
 
**********************************************************
 */
//
//  AccountsData.swift
//  MyPIM
//  Created by Osman Balci on 5/25/22.
//  Created by Yuxuan Li on 3/21/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import Foundation
import SwiftUI

var accountStructList = [Accounts]()

var accountDataChanged = false

/*
 *********************************
 MARK: Read Account Data File
 *********************************
 */
public func readAccountsDataFile() {
    
    let jsonDataFullFilename = "AccountsData.json"
    
    // Obtain URL of the data file in document directory on user's device
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(jsonDataFullFilename)
    
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: urlOfJsonFileInDocumentDirectory.path) {
        print("Get into the read func")
        
        accountStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: jsonDataFullFilename, fileLocation: "Document Directory")
        print("AccountsData is loaded from document directory")
        
    } else {
        
        accountStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: jsonDataFullFilename, fileLocation: "Main Bundle")
        print("AccountData is loaded from main bundle")
        
        accountDataChanged = true
    }
}
    /*
     ********************************************************
     MARK: Write Accounts Data File to Document Directory
     ********************************************************
     */
    public func writeAccountsDataFile() {
        
        // Obtain URL of the JSON file into which data will be written
        let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("AccountsData.json")

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(accountStructList) {
            do {
                try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
            } catch {
                fatalError("Unable to write encoded photo data to document directory!")
            }
        } else {
            fatalError("Unable to encode photo data!")
        }
        
        // Set global flag defined above on top
        accountDataChanged = false
    }


