
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
 *///
//  ContactList.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/17/23.
//  Created by Osman Balci on 5/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI

struct ContactList: View {
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { item in
                    NavigationLink(destination: ContactsDetail(contact: searchItemContact(searchListItem: item)))
                    {
                        ContactsItem(contact: searchItemContact(searchListItem: item))
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                
            }   // End of List
            .navigationBarTitle(Text("Contacts"), displayMode: .inline)
            // Place the Edit button on left and Add (+) button on right of the navigation bar
            .navigationBarItems(leading: EditButton(), trailing:
                NavigationLink(destination: AddContact()) {
                    Image(systemName: "plus")
                })

        }   // End of NavigationView
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .customNavigationViewStyle()  // Given in NavigationStyle.swift
    }
    
    /*
     --------------------------------------
     MARK: Get Contact for Search List Item
     --------------------------------------
     */
    func searchItemContact(searchListItem: String) -> Contacts {
        
        // Find the index number of countriesList matching the fish attribute 'id'
        let index = userData.contactsList.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
        
        return userData.contactsList[index]
    }
    
    /*
     --------------------
     MARK: Search Results
     --------------------
     */
    var searchResults: [String] {
        if searchText.isEmpty {
            return userData.searchableOrderedContactList
        } else {
            return userData.searchableOrderedContactList.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    
    /*
     ---------------------------
     MARK: Delete Selected Contact
     ---------------------------
     */
    func delete(at offsets: IndexSet) {
        /*
         'offsets.first' is an unsafe pointer to the index number of the array element
         to be deleted. It is nil if the array is empty. Process it as an optional.
         */
        if let index = offsets.first {
            
            let nameOfFileToDelete = userData.contactsList[index].photoFullFilename
            
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
            userData.contactsList.remove(at: index)
            
            // Set the global variable point to the changed list
            contactStructList = userData.contactsList
            
            // Set global flag defined in AlbumPhotosData
            contactDataChanged = true
        }
    }
    
    /*
     -------------------------
     MARK: Move Selected Photo
     -------------------------
     */
    func move(from source: IndexSet, to destination: Int) {
        
        userData.contactsList.move(fromOffsets: source, toOffset: destination)
        
        // Set the global variable point to the changed list
        contactStructList = userData.contactsList
        
        // Set global flag defined in AlbumPhotosData
        contactDataChanged = true
    }
}

struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList()
    }
}
