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
//  ContactStruct.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/21/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI
struct Contacts: Hashable, Codable, Identifiable {

        var id: UUID
        var firstName: String
        var lastName: String
        var photoFullFilename: String
        var company: String
        var phone: String
        var email: String
        var addressLine1: String
        var addressLine2: String
        var addressCity: String
        var addressState: String
        var addressZipcode: String
        var addressCountry: String
    }
/*
 {
     "id": "241CFB9E-E034-4A2D-9824-A79B4204FECB",
     "firstName": "Jennifer",
     "lastName": "Lawrence",
     "photoFullFilename": "ACF6976E-660D-486E-BA56-9559D8517261.jpg",
     "company": "Jennifer Lawrence Foundation",
     "phone": "(674) 465-9834",
     "email": "JenniferLawrence@gmail.com",
     "addressLine1": "4350 Brownsboro Road",
     "addressLine2": "Suite 110",
     "addressCity": "Louisville",
     "addressState": "KY",
     "addressZipcode": "40207-1681",
     "addressCountry": "USA"
 },
 */
