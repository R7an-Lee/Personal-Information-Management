
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
//  MainView.swift
//  PhotosVideos
//  Modified by Yuxuan Li on 3/19/23
//  Created by Osman Balci on 5/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            
            NotesList()
                .tabItem {
                    Image(systemName: "doc.richtext")
                    Text("Notes")
                }
            
            TaskList()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("To Do")
                }
            ContactList()
                .tabItem {
                    Image(systemName: "rectangle.stack.person.crop")
                    Text("Contacts")
                }
            
            AccountsList()
                .tabItem{
                    Image(systemName: "key.icloud")
                    Text("Accounts")
                }
            
            Settings()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }   // End of TabView
            .font(.headline)
            .imageScale(.medium)
            .font(Font.title.weight(.regular))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
