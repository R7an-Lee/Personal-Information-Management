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
//  AppDelegate.swift
//  MyPIM
//
//  Modified by Yuxuan Li on 3/19/23.
//  Created by Osman Balci on 5/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        readNotesDataFile()          
        
        // Read to do list data file upon app launch
        readToDoListDataFile()
        // Get permission to obtain user's geolocation upon app launch
        getPermissionForLocation()          // In CurrentLocation.swift
        readContactsDataFile()
        readAccountsDataFile()
        
        return true
    }

}
