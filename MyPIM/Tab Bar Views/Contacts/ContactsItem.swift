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
//  ContactItem.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/17/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct ContactsItem: View {
    // Input Parameter
    let contact: Contacts
    
    var body: some View {
        HStack {
                getImageFromDocumentDirectory(filename: contact.photoFullFilename.components(separatedBy: ".")[0],
                                              fileExtension: contact.photoFullFilename.components(separatedBy: ".")[1],
                                              defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            VStack(alignment: .leading) {
                Text(contact.firstName + contact.lastName)
                Text(contact.addressCity + "," + contact.addressState + "," + contact.addressCountry)
                HStack {
                    Image(systemName:"phone.circle")
                        .font(.system(size: 20))
                    Text(contact.phone)
                    
                }
                
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
            
        }   // End of HStack
    }
}

struct ContactsItem_Previews: PreviewProvider {
    static var previews: some View {
        ContactsItem(contact:contactStructList[0])
    }
}
