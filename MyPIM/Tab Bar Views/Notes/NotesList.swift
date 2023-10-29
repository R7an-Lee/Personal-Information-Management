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
//  NotesList.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/20/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//  Created by Osman Balci on 5/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI

struct NotesList: View {
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.notesList) { aNote in
                    NavigationLink(destination: NoteDetails(note: aNote)) {
                        NoteItem(note: aNote)
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                
            }   // End of List
            .navigationBarTitle(Text("Multimedia Notes"), displayMode: .inline)
            // Place the Edit button on left and Add (+) button on right of the navigation bar
            .navigationBarItems(leading: EditButton(), trailing:
                NavigationLink(destination: AddNote()) {
                    Image(systemName: "plus")
                })

        }   // End of NavigationView
            .customNavigationViewStyle()  // Given in NavigationStyle.swift
    }
    
    /*
     ---------------------------
     MARK: Delete Selected Photo
     ---------------------------
     */
    func delete(at offsets: IndexSet) {
        /*
         'offsets.first' is an unsafe pointer to the index number of the array element
         to be deleted. It is nil if the array is empty. Process it as an optional.
         */
        if let index = offsets.first {
            
            let nameOfFileToDelete = userData.notesList[index].photoFullFilename
            
            // Obtain the document directory file path of the file to be deleted
            let filePath = documentDirectory.appendingPathComponent(nameOfFileToDelete).path
            
            do {
                let fileManager = FileManager.default
                
                // Check if the photo file exists in document directory
                if fileManager.fileExists(atPath: filePath) {
                    // Delete the photo file from document directory
                    try fileManager.removeItem(atPath: filePath)
                } else {
                    // Photo file does not exist in document directory
                }
            } catch {
                print("Unable to delete the note file from the document directory.")
            }
            
            // Remove the selected photo from the list
            userData.notesList.remove(at: index)
            
            // Set the global variable point to the changed list
            multimediaNoteStructList = userData.notesList
            
            // Set global flag defined in AlbumPhotosData
            noteDataChanged = true
        }
    }
    
    /*
     -------------------------
     MARK: Move Selected Photo
     -------------------------
     */
    func move(from source: IndexSet, to destination: Int) {
        
        userData.notesList.move(fromOffsets: source, toOffset: destination)
        
        // Set the global variable point to the changed list
        multimediaNoteStructList = userData.notesList
        
        // Set global flag defined in AlbumPhotosData
        noteDataChanged = true
    }
}

struct NotesList_Previews: PreviewProvider {
    static var previews: some View {
        NotesList()
    }
}
