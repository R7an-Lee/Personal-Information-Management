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
//  InformationData.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/20/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation


// Global array of structs
var multimediaNoteStructList = [MultimediaNote]()
var toDoListStructList = [ToDoList]()

var sortedListTitle: [ToDoList] = []
var sortedListDate: [ToDoList] = []
var sortedListPriority: [ToDoList] = []
let priorityValues = ["High": 3, "Low": 2, "Normal":1]
/*
 Global flag to track changes to multimediaNotesStructList.
 If changes are made, multimediaNoteStructList will be written to
 document directory when the app life cycle state changes.
 */
var noteDataChanged = false
var taskDataChanged = false

var contactStructList = [Contacts]()
var contactDataChanged = false


/*
 *********************************
 MARK: Read Notes Data File
 *********************************
 */
public func readNotesDataFile() {
    
    let jsonDataFullFilename = "MultimediaNotesData.json"
    
    // Obtain URL of the data file in document directory on user's device
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(jsonDataFullFilename)
    
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: urlOfJsonFileInDocumentDirectory.path) {

        multimediaNoteStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: jsonDataFullFilename, fileLocation: "Document Directory")
        print("NotesData is loaded from document directory")
        
    } else {
        /*
         AlbumPhotosData.json file does not exist in the document directory; Load it from the main bundle.
         This happens only once when the app is launched for the very first time.
         */
        
        multimediaNoteStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: jsonDataFullFilename, fileLocation: "Main Bundle")
        print("NotesData is loaded from main bundle")
        
        /*
         ===============================================================
         |   Copy Notes Files from Assets to Document Directory  |
         ===============================================================
         */
        for note in multimediaNoteStructList {
            
            // Example photo fullFilename = "D3C83FED-B482-425C-A3F8-6C90A636DFBF.jpg"
            let array = note.photoFullFilename.components(separatedBy: ".")
            
            // array[0] = "D3C83FED-B482-425C-A3F8-6C90A636DFBF"
            // array[1] = "jpg"
            
            // Copy each photo file from Assets.xcassets to document directory
            copyImageFileFromAssetsToDocumentDirectory(filename: array[0], fileExtension: array[1])
        }
        
        // Set global flag defined above on top
        noteDataChanged = true
    }
}

/*
 ********************************************************
 MARK: Write Notes Data File to Document Directory
 ********************************************************
 */
public func writeNotesDataFile() {
    
    // Obtain URL of the JSON file into which data will be written
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("MultimediaNotesData.json")

    // Encode albumPhotoStructList into JSON and write it into the JSON file
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(multimediaNoteStructList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
        } catch {
            fatalError("Unable to write encoded note data to document directory!")
        }
    } else {
        fatalError("Unable to encode note data!")
    }
    
    // Set global flag defined above on top
    noteDataChanged = false
}


//TO DO LIST PART

/*
 *********************************
 MARK: Read TO DO List Data File
 *********************************
 */
public func readToDoListDataFile() {
    
    let jsonDataFullFilename = "ToDoListData.json"
    
    // Obtain URL of the data file in document directory on user's device
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(jsonDataFullFilename)
    
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: urlOfJsonFileInDocumentDirectory.path) {

        toDoListStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: jsonDataFullFilename, fileLocation: "Document Directory")
        print("TaskData is loaded from document directory")
        
    } else {
        /*
         AlbumPhotosData.json file does not exist in the document directory; Load it from the main bundle.
         This happens only once when the app is launched for the very first time.
         */
        
        toDoListStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: jsonDataFullFilename, fileLocation: "Main Bundle")
        print("TaskData is loaded from main bundle")
        
        
        // Set global flag defined above on top
        taskDataChanged = true
    }
}

/*
 *********************************
 MARK: Creat Sort Function
 *********************************
 */

public func createSortedLists() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
    sortedListTitle = toDoListStructList.sorted { $0.title < $1.title }
    sortedListDate = toDoListStructList.sorted {
        let date1 = dateFormatter.date(from: $0.dueDateAndTime)!
        let date2 = dateFormatter.date(from: $1.dueDateAndTime)!
        return date1 < date2 }
    sortedListPriority = sortedListTitle.sorted { priorityValues[$0.priority]! > priorityValues[$1.priority]! }

}
    
