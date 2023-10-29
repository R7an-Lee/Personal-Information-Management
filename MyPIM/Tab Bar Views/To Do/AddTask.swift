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
//  AddTask.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/21/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI



struct AddTask: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userData: UserData
    
    @State private var selectedPriorityIndex = 0
    @State private var selectedCompletedIndex = 1
    var completedType = ["Yes", "No"]
    var sortedType = ["Low", "Normal", "High" ]
    
    
    @State private var taskTitleFieldValue = ""
    @State private var taskDescrptionFieldValue = ""
    
    @State private var taskPriorityFieldValue = ""
    @State private var taskCompletedFieldValue = true
    //@State private var taskDueFieldValue = ""
    
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var selectedDueDateAndTime = Date()
    
    //@State private var videoReleaseDate = Date()
        var dateAndTimeFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"   // e.g., 5:19 PM
            return formatter
        }
    
    
        var selectedDateAndTime: String {
            dateAndTimeFormatter.string(from: selectedDueDateAndTime)
        }
       
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long     // e.g., August 14, 2020
            return formatter
        }
       
        var dateClosedRange: ClosedRange<Date> {
            // Set minimum date to 40 years earlier than the current year
            let minDate = Calendar.current.date(byAdding: .year, value: -40, to: Date())!
           
            // Set maximum date to 10 years later than the current year
            let maxDate = Calendar.current.date(byAdding: .year, value: 10, to: Date())!
            return minDate...maxDate
        }

    var body: some View {
        Form {
            
            
            Section(header: Text("TASK TITLE")) {
                HStack {
                    TextField("Enter Task Title", text: $taskTitleFieldValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.words)
                    
                }   // End of HStack
            }  //end of task title
            
            Section(header: Text("TAKE NOTES BY ENTERING TEXT"), footer:
                                    Button(action: {
                                        self.dismissKeyboard()
                                    }) {
                                        Image(systemName: "keyboard")
                                            .font(Font.title.weight(.light))
                                            .foregroundColor(.blue)
                                    }
                        ) {
                            TextEditor(text: $taskDescrptionFieldValue)
                                .frame(height: 100)
                                .font(.custom("Helvetica", size: 14))
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                        }
            
            Section(header: Text("TASK PRIORITY LEVEL")) {
                Picker("", selection: $selectedPriorityIndex) {
                                                ForEach(0 ..< sortedType.count, id: \.self) {
                                                    Text(sortedType[$0])
                                                }
                                            }
                                            .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("TASK COMPLETED")) {
                Picker("", selection: $selectedCompletedIndex) {
                                                ForEach(0 ..< completedType.count, id: \.self) {
                                                    Text(completedType[$0])
                                                }
                                            }
                                            .pickerStyle(SegmentedPickerStyle())
            }
            
            
            Section(header: Text("TASK DUE DATE AND TIME").padding(.top, 100)) {
                            DatePicker(
                                selection: $selectedDueDateAndTime,
                                in: dateClosedRange,
                                displayedComponents: [.hourAndMinute, .date]
                            ){
                                Text("Due Date And Time")
                            }
                        }
            
            
        } //end of form
        .font(.system(size: 14))
        .navigationBarTitle(Text("New Task"), displayMode: .inline)
        // Use single column navigation view for iPhone and iPad
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarItems(trailing:
            Button(action: {
                if inputDataValidated() {
                    saveNewTask()
                    
                    showAlertMessage = true
                    alertTitle = "New Task Added!"
                    alertMessage = "New Task is successfully added to your to do list."
                } else {
                    showAlertMessage = true
                    alertTitle = "Missing Input Data!"
                    alertMessage = "Task must be taken or picked with a title.\nCategory and Rating defaults are used if not selected."
                }
            }) {
                Text("Save")
        })
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
              Button("OK") {
                  if alertTitle == "New Task Added!" {
                      // Dismiss this view and go back to the previous view
                      dismiss()
                  }
              }
            }, message: {
              Text(alertMessage)
            })
        
        
    }  //end of view
    
    
    
    
    
    //dismiss keyboard function
    func dismissKeyboard() {

            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

        }
    
    /*
     ---------------------------
     MARK: Input Data Validation
     ---------------------------
     */
    func inputDataValidated() -> Bool {
        
        // Remove spaces, if any, at the beginning and at the end of the entered photo title
        let taskTitle = taskTitleFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        let taskDescription = taskDescrptionFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        /*
         Photo must be taken or picked with a title.
         Category and Rating defaults are used if not selected.
         */
        if taskTitle.isEmpty || taskDescription.isEmpty {
            return false
        }
        return true
    }
    
    /*
    -----------------------------
    MARK: Save New Photo to Album
    -----------------------------
    */
    func saveNewTask() {
        
        //-----------------------------
        // Obtain Current Date and Time
        //-----------------------------
        //let date = Date()
        
        // Instantiate a DateFormatter object
        let dateFormatter = DateFormatter()

        // Set the date format to yyyy-MM-dd at HH:mm:ss
        dateFormatter.dateFormat = "yyyy-MM-dd' at 'HH:mm:ss"
        
        // Format current date and time as above and convert it to String
        //let currentDateTime = dateFormatter.string(from: date)
        
        
        if selectedCompletedIndex == 0{
            taskCompletedFieldValue = true
        }
        else if selectedCompletedIndex == 1{
            taskCompletedFieldValue = false
        }
        
        if selectedPriorityIndex == 0 {
            taskPriorityFieldValue = "Low"
        }
        else if  selectedPriorityIndex == 1{
            taskPriorityFieldValue = "Normal"
        }
        else if selectedPriorityIndex == 2{
            taskPriorityFieldValue = "High"
        }
        
        //---------------------------------------------------------------
        // Create a new instance of the AlbumPhoto struct and dress it up
        //---------------------------------------------------------------
        let newTask = ToDoList(id: UUID(),
                                       title: taskTitleFieldValue,
                               description: taskDescrptionFieldValue,
                               priority: taskPriorityFieldValue,
                               completed: taskCompletedFieldValue,
                               dueDateAndTime: selectedDateAndTime
                                       )
        
        // Append the new photo to photosList
        userData.toDoList.append(newTask)
        
        // Set the global variable point to the changed list
        toDoListStructList = userData.toDoList
        
        createSortedLists()
        
        // Set global flag defined in AlbumPhotosData
        taskDataChanged = true
        
        // Initialize @State variables
        taskTitleFieldValue = ""
        taskDescrptionFieldValue=""
        selectedPriorityIndex = 0
        selectedCompletedIndex = 1
        selectedDueDateAndTime = Date()
        //photoCategorySelectedIndex = 4
        
    }   // End of function
}  //end of struct

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}
