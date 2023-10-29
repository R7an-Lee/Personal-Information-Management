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
//  MyPIMApp.swift
//  MyPIM
//
//  Modified by Yuxuan Li on 3/19/23.
//  Created by Osman Balci on 5/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI

@main
struct PhotosVideosApp: App {
    /*
     UserDefaults is a class that provides an interface to the user’s defaults database,
     where you store Key-Value pairs persistently across launches of your app.
 
     The @AppStorage is a property wrapper type that reflects a value from UserDefaults
     and invalidates a view on a change in value in that user default.
    
     We use 'private var darkMode' property wrapped with @AppStorage("darkMode")
     to change or read the value for the Key "darkMode" in UserDefaults database.
 
     Every view in the app is automatically updated / refreshed whenever
     the Key 'darkMode' value changes in UserDefaults database.
     */
    @AppStorage("darkMode") private var darkMode = false
    
    /*
     Use the UIApplicationDelegateAdaptor property wrapper to direct SwiftUI
     to use the AppDelegate class for the application delegate.
     */
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    /*
     @Environment property wrapper for SwiftUI's pre-defined key scenePhase is declared to
     monitor changes of app's life cycle states such as active, inactive, or background.
     The \. indicates that we access scenePhase by its object reference, not by its value.
     */
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            // ContentView is the root view to be shown first upon app launch
            ContentView()
                // Change the color mode of the entire app to Dark or Light
                .preferredColorScheme(darkMode ? .dark : .light)
            
                /*
                 Inject an instance of UserData() class into the environment and make it available to
                 every View subscribing to it by declaring '@EnvironmentObject var userData: UserData'
                 */
                .environmentObject(UserData())
                .environmentObject(AudioPlayer())
        }
        .onChange(of: scenePhase) { _ in
            /*
             Save data changes if any whenever app life cycle state changes.
             Global flag 'dataChanged' is defined in AlbumPhotosData.
             */
            if noteDataChanged {
                writeNotesDataFile()  // Given in InformationData
            }
            
            if taskDataChanged {
                createSortedLists()  // Given in InformationData
            }
            
            if contactDataChanged {
                writeContactsDataFile()
            }
             
        }
    }
}

