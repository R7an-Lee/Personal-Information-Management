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
//  UserData.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/20/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//
//  Created by Osman Balci on 5/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
    /*
     ===============================================================================
     |                   Publisher-Subscriber Design Pattern                       |
     ===============================================================================
     | Publisher:   @Published var under class conforming to ObservableObject      |
     | Subscriber:  Any View declaring '@EnvironmentObject var userData: UserData' |
     ===============================================================================
     
     By modifying the first View to be shown, ContentView(), with '.environmentObject(UserData())' in
     Photo_AlbumApp, we inject an instance of this UserData() class into the environment and make it
     available to every View subscribing to it by declaring '@EnvironmentObject var userData: UserData'.
     
     When a change occurs in UserData, every View subscribed to it is notified to re-render its View.
     */
    
    /*
     ---------------------------
     |   Published Variables   |
     ---------------------------
     */
    
    // Publish photosList with initial value of albumPhotoStructList obtained in AlbumPhotosData.swift
    //@Published var photosList = albumPhotoStructList
    
    @Published var notesList = multimediaNoteStructList
    
    @Published var toDoList = toDoListStructList
    
    @Published var contactsList = contactsStructList
    
    @Published var searchableOrderedContactList = orderedSearchableContactList
    
    @Published var accountsList = accountStructList
    
    
}

