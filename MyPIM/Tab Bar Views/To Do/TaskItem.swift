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
//  ToDoItem.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/21/23.
//  Created by Osman Balci on 5/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI
import AVFoundation

struct TaskItem: View {
    
    // Input Parameter
    let task: ToDoList
    
    var body: some View {
        HStack {
            if task.completed == true {
                // It is completed
                Image(systemName:"checkmark.square")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            } else {
                // It is not completed
                // This public function is given in UtilityFunctions.swift
                Image(systemName:"square")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }
            VStack(alignment: .leading) {
                if task.priority == "High"{
                    Text(task.title)
                        .foregroundColor(.red)
                        .font(.system(size:14))
                    Text(task.dueDateAndTime)
                        .foregroundColor(.red)
                        .font(.system(size:14))
                }
                else if task.priority == "Low"{
                    Text(task.title)
                        .foregroundColor(.black)
                        .font(.system(size:14))
                    Text(task.dueDateAndTime)
                        .foregroundColor(.black)
                        .font(.system(size:14))
                }
                else {
                    Text(task.title)
                        .foregroundColor(.green)
                        .font(.system(size:14))
                    Text(task.dueDateAndTime)
                        .foregroundColor(.green)
                        .font(.system(size:14))
                }
                
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
            
        }   // End of HStack
    }
    
    
}

struct TaskItem_Previews: PreviewProvider {
    static var previews: some View {
        TaskItem(task: toDoListStructList[0])
    }
}
