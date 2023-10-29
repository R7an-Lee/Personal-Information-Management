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
//  ToDoDetails.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/21/23.
//  Created by Osman Balci on 6/7/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI
import MapKit
import AVKit
import AVFoundation


struct TaskDetails: View {
    
    // Input Parameter
    let task: ToDoList
    
    
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            
            Section(header: Text("TO-DO LIST TASK TITLE")) {
                Text(task.title)
            }
            
            Section(header: Text("TO-DO LIST TASK DESCRIPTION")) {
                Text(task.description)
            }
            
            Section(header: Text("TO-DO LIST PRIORITY LEVEL")) {
                Text(task.priority)
            }
            
            Section(header: Text("TO-DO LIST TASK COMPLETED")) {
                if task.completed == true {
                    Text("Yes")
                }
                else {
                    Text("No")
                }
            }
            
            Section(header: Text("TO-DO LIST TASK DUE DATE AND TIME")) {
                Text(task.dueDateAndTime)
            }
                
                
            
            
        }   // End of Form
        .font(.system(size: 14))
        .navigationBarTitle(Text("To-Do Task Details"), displayMode: .inline)
        .navigationBarItems(trailing:
            NavigationLink(destination: ChangeTask(task: task)) {
                Text("Change")
            }
        )
    }   // End of body var
    
}

struct TaskDetails_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetails(task: toDoListStructList[0])
    }
}
