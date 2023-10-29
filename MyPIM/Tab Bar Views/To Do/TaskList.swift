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
//  ToDoList.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/21/23.
//  Created by Osman Balci on 5/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI

struct TaskList: View {
    
    
    @State private var selectedSortedListIndex = 0
        var sortedType = ["Title", "Due Date", "Priority" ]
        var todoListToDisplay: [ToDoList] {
                switch selectedSortedListIndex {
                case 0:
                    return sortedListTitle
                case 1:
                    return sortedListDate
                case 2:
                    return sortedListPriority
                default:
                    return sortedListTitle
                }
            }


    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Picker("", selection: $selectedSortedListIndex) {
                                                    ForEach(0 ..< sortedType.count, id: \.self) {
                                                        Text(sortedType[$0])
                                                    }
                                                }
                                                .pickerStyle(SegmentedPickerStyle())
                    
                } //end of ZStack
                List {
                    ForEach(todoListToDisplay) { aTask in
                        NavigationLink(destination: TaskDetails(task: aTask)) {
                            TaskItem(task: aTask)
                        }
                    }
                    .onDelete(perform: delete)
                    
                }   // End of List
                .navigationBarTitle(Text("To-Do List"), displayMode: .inline)
                // Place the Edit button on left and Add (+) button on right of the navigation bar
                .navigationBarItems(leading: EditButton(), trailing:
                                        NavigationLink(destination: AddTask()) {
                    Image(systemName: "plus")
                })
            } //END of VStack
        }   // End of NavigationView
            .customNavigationViewStyle()  // Given in NavigationStyle.swift
    }
    
    /*
     ---------------------------
     MARK: Delete Selected Task
     ---------------------------
     */
    func delete(at offsets: IndexSet) {
        
        if selectedSortedListIndex == 0{
            if let index = offsets.first {
                let deletedItem = sortedListTitle.remove(at: index)
                userData.toDoList.removeAll { $0.id == deletedItem.id }
                sortedListDate.removeAll { $0.id == deletedItem.id }
                sortedListPriority.removeAll { $0.id == deletedItem.id }
            }
            
        }
        else if selectedSortedListIndex == 1{
            if let index = offsets.first {
                let deletedItem = sortedListDate.remove(at: index)
                userData.toDoList.removeAll { $0.id == deletedItem.id }
                sortedListTitle.removeAll { $0.id == deletedItem.id }
                sortedListPriority.removeAll { $0.id == deletedItem.id }
            }
        }
        else{
            if let index = offsets.first {
                let deletedItem = sortedListPriority.remove(at: index)
                userData.toDoList.removeAll { $0.id == deletedItem.id }
                sortedListTitle.removeAll { $0.id == deletedItem.id }
                sortedListDate.removeAll { $0.id == deletedItem.id }
            }
        }
        
        toDoListStructList = userData.toDoList
        taskDataChanged = true
            
           
            
            
        
    }
    
}

struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
    }
}
