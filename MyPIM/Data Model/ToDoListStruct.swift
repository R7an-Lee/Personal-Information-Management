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
//  ToDoListStruct.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/20/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//



import SwiftUI

struct ToDoList: Hashable, Codable, Identifiable {
    
    var id: UUID
    var title: String
    var description: String
    var priority: String
    var completed: Bool
    var dueDateAndTime: String
    
}
/*
 {
     "id": "3615D2F3-6958-4742-92E5-93076CAAF727",
     "title": "Go Grocery Shopping",
     "description": "Barbecue sauce; Brown rice; Extra virgin olive oil, canola oil, nonfat cooking spray; Ground turkey or chicken; Hot pepper sauce; Jarred capers and olives; Mustard; Red-wine vinegar; Reduced-sodium lunchmeat (turkey, roast beef); Salmon, halibut, trout, mackerel, or your favorite seafood; Salsa; Skinless chicken or turkey breasts; Steel-cut or instant oatmeal; Tomato sauce; Whole wheat or whole-grain pasta; Whole-grain cereal bars; Whole-grain or multigrain cereals.",
     "priority": "Normal",
     "completed": true,
     "dueDateAndTime": "2023-02-04 at 20:00"
 },
 */
