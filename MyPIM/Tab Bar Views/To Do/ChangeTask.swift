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
//  ChangeTask.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/21/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct ChangeTask: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userData: UserData
    @State private var dataChanged = false
    @State private var isNavigating = false
    
    
    @State private var newtodoTitle = ""
    @State private var newtodoDescription = ""

    @State private var selectedCompletedIndex = 1
    @State private var selectedPriorityIndex = 0
    var priority = ["Low", "Normal", "High" ]
    var Completed = ["Yes", "No"]
    
    let task: ToDoList
    
    @State private var dueDateAndTime = Date()
    
    var dateAndTimeFormatter: DateFormatter {
            let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
            return formatter
        }
    var selectedDateAndTime: String {
        dateAndTimeFormatter.string(from: dueDateAndTime)
    }
    var dateClosedRange: ClosedRange<Date> {
            let minDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
            let maxDate = Calendar.current.date(byAdding: .year, value: 10, to: Date())!
            return minDate...maxDate
        }
    var body: some View {
        Form {
            
            Section(header: Text("CHANGE TASK TITLE")) {
                Text(task.title)
                TextField("Enter new task title", text: $newtodoTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .autocapitalization(.words)
            }
            
            Section(header: Text("CHANGE TASK DESCRIPTION")) {
                Text(task.description)
                TextField("Enter new task description", text: $newtodoDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .autocapitalization(.words)
            }
            
            Section(header: Text("CHANGE TASK PRIORITY LEVEL")) {
                Text("Current Priority = " + task.priority)

                    VStack {    // Enclose within VStack so that Picker is centered
                        Picker("", selection: $selectedPriorityIndex) {
                            ForEach(0 ..< priority.count, id: \.self) {
                                Text(String(priority[$0]))
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Section(header: Text("CHANGE TASK COMPLETED")) {
                Text("Current Completed = " + (task.completed ? "Yes" : "No"))
                VStack {    // Enclose within VStack so that Picker is centered
                    Picker("", selection: $selectedCompletedIndex) {
                        ForEach(0 ..< Completed.count, id: \.self) {
                            Text(String(Completed[$0]))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Section(header: Text("CHANGE TASK DUE DATE AND TIME")) {
                Text("Current Due Date and Time = " + task.dueDateAndTime)
                DatePicker(
                    selection: $dueDateAndTime,
                    in: dateClosedRange,
                    displayedComponents: [.date, .hourAndMinute]
                ){
                    Text("Due Date\nand Time")
                    
                }
            } //end of section
            
            
            
            
            
        } //end of form
        .font(.system(size: 14))
        .navigationBarTitle(Text("Change Task"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                saveNewChangeToTask()
                dismiss()
                dismiss()
            }) {
                Text("Save")
        })
        
        
    } //end of var body
    /*
    -----------------------------
    MARK: Save Task
    -----------------------------
    */
    func saveNewChangeToTask() {
        var updatedTask = task
        if newtodoTitle != "" && newtodoTitle != task.title {
                updatedTask.title = newtodoTitle
                dataChanged = true
            }
        else{
            updatedTask.title = task.title
        }
            
            if newtodoDescription != "" && newtodoDescription != task.description {
                updatedTask.description = newtodoDescription
                dataChanged = true
            }
        else{
            updatedTask.description = task.description
        }
            
            if priority[selectedPriorityIndex] != task.priority {
                updatedTask.priority = priority[selectedPriorityIndex]
                dataChanged = true
            }
        else{
            updatedTask.priority = task.priority
        }
            
            if Completed[selectedCompletedIndex] != (task.completed ? "Yes" : "No") {
                updatedTask.completed = Completed[selectedCompletedIndex] == "Yes"
                dataChanged = true
            }
        else{
            updatedTask.completed = task.completed
        }
            
            if selectedDateAndTime != task.dueDateAndTime {
                updatedTask.dueDateAndTime = selectedDateAndTime
                dataChanged = true
            }
        else{
            updatedTask.dueDateAndTime = task.dueDateAndTime
        }
        if dataChanged{
           
            if let index = userData.toDoList.firstIndex(where: { $0.id == task.id }) {
                userData.toDoList.remove(at: index)
                userData.toDoList.append(updatedTask)
                    }
            
            // Append the new photo to photosList
            toDoListStructList = userData.toDoList
            createSortedLists()
            
            // Set global flag defined in AlbumPhotosData
            taskDataChanged = true
            
            // Initialize @State variables
            newtodoTitle = ""
            newtodoDescription = ""
            selectedPriorityIndex = 0
            selectedCompletedIndex = 1
            dueDateAndTime = Date()
        }
    }   // End of function
    
    
    
    
    
    
} //end of struct




struct ChangeTask_Previews: PreviewProvider {
    static var previews: some View {
        ChangeTask(task: toDoListStructList[0])
    }
}
