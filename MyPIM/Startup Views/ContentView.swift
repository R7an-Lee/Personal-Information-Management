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
//  ContentView.swift
//  MyPIM
//
//  Modified by Yuxuan Li on 3/19/23.
//
//  Created by Osman Balci on 5/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @State private var userAuthenticated = false
    
    var body: some View {
        
        if userAuthenticated {
            // Foreground View
            MainView()
        } else {
            ZStack {
                // Background View
                LoginView(canLogin: $userAuthenticated)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
