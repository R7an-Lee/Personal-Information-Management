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
//  AccountStruct.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/21/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct Accounts: Hashable, Codable, Identifiable {

        var id: UUID
        var title: String
        var category: String
        var url: String
        var username: String
        var password: String
        var notes: String
    }

/*
 {
     "id": "26A715B7-A82D-4EDD-866F-D1F8230C3135",
     "title": "Bank of America",
     "category": "Bank",
     "url": "https://www.bankofamerica.com/",
     "username": "JenniferLawrence",
     "password": "Dark-Phoenix/2019",
     "notes": "Bank of America is a global leader in wealth management, corporate and investment banking and trading across a broad range of asset classes, serving corporations, governments, institutions and individuals around the world."
 },*/
