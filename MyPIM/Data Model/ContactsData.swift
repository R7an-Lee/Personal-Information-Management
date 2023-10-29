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
//  ContactsData.swift
//  MyPIM
//
//  Modified by Yuxuan Li on 3/21/23.
//  Created by Osman Balci on 5/25/22.
//

import Foundation
import SwiftUI
import CoreLocation

var contactsStructList = [Contacts]()

var contactsDataChanged = false
var orderedSearchableContactList = [String]()

/*
 *********************************
 MARK: Read Contact Data File
 *********************************
 */
public func readContactsDataFile() {
    var documentDirectoryHasFiles = false
    let jsonDataFullFilename = "ContactsData.json"
    
    // Obtain URL of the data file in document directory on user's device
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(jsonDataFullFilename)
    
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: urlOfJsonFileInDocumentDirectory.path) {
        
        documentDirectoryHasFiles = true
        contactsStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: jsonDataFullFilename, fileLocation: "Document Directory")
        print("ContactsData is loaded from document directory")
        
    } else {
        /*
         AlbumPhotosData.json file does not exist in the document directory; Load it from the main bundle.
         This happens only once when the app is launched for the very first time.
         */
        
        contactsStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: jsonDataFullFilename, fileLocation: "Main Bundle")
        print("ContactsData is loaded from main bundle")
        documentDirectoryHasFiles = false
        
        for contact in contactsStructList {
            
            // Example photo fullFilename = "D3C83FED-B482-425C-A3F8-6C90A636DFBF.jpg"
            let array = contact.photoFullFilename.components(separatedBy: ".")
            
            // array[0] = "D3C83FED-B482-425C-A3F8-6C90A636DFBF"
            // array[1] = "jpg"
            
            // Copy each photo file from Assets.xcassets to document directory
            copyImageFileFromAssetsToDocumentDirectory(filename: array[0], fileExtension: array[1])
            
            let selectedContactAttributesForSearch =
            "\(contact.id)|\(contact.firstName)|\(contact.lastName)|\(contact.company)|\(contact.addressLine1)|\(contact.addressCity)|\(contact.addressState)|\(contact.addressCountry)"
            orderedSearchableContactList.append(selectedContactAttributesForSearch)
        }
        
        // Set global flag defined above on top
        contactsDataChanged = true
    }
    
    if documentDirectoryHasFiles{
        let urlOfFileInDocDir = documentDirectory.appendingPathComponent("orderedSearchableContactList")

        let arrayFromFile: NSArray? = NSArray(contentsOf: urlOfFileInDocDir)
        if let arrayObtained = arrayFromFile {
            // Store the unique id of the created array into the global variable
            orderedSearchableContactList = arrayObtained as! [String]
        } else {
            print("orderedSearchableContactList file is not found in document directory on the user's device!")
        }
    }
}

/*
 ********************************************************
 MARK: Write Contact Data File to Document Directory
 ********************************************************
 */
public func writeContactsDataFile() {
    
    // Obtain URL of the JSON file into which data will be written
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("ContactsData.json")
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(contactsStructList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
        } catch {
            fatalError("Unable to write encoded photo data to document directory!")
        }
    } else {
        fatalError("Unable to encode contact data!")
    }
    
    // Obtain URL of the file in document directory on the user's device
    let urlOfFileInDocDirectory = documentDirectory.appendingPathComponent("orderedSearchableContactList")
    
    (orderedSearchableContactList as NSArray).write(to: urlOfFileInDocDirectory, atomically: true)
    
    // Set global flag defined above on top
    contactsDataChanged = false
}
