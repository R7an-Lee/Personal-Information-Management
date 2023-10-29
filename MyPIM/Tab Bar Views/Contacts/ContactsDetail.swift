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
//  ContactDetail.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/17/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct ContactsDetail: View {
    
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    let contact: Contacts
    
    var body: some View {
        Form {
            Section(header: Text("NAME")) {
                Text(contact.firstName + contact.lastName)
            }
            
            Section(header: Text("PHOTO")) {
                // This public function is given in UtilityFunctions.swift
                getImageFromDocumentDirectory(filename: contact.photoFullFilename.components(separatedBy: ".")[0],
                                              fileExtension: contact.photoFullFilename.components(separatedBy: ".")[1],
                                              defaultFilename: "ImageUnavailable")
                    
            } //end of section ohoto
            
            Section(header: Text("COMPANY NAME")) {
                Text(contact.company)
            }
            
            Section(header: Text("PHONE")) {
                HStack {
                    Image(systemName: "phone.circle")
                        .font(.system(size: 20))
                    Text(contact.phone)
                    
                }
                
            }
            
            Section(header: Text("EMAIL ADDRESS")) {
                HStack {
                    Image(systemName: "envelope")
                        .font(.system(size: 20))
                    Text(contact.email)
                }
                
            }
            Section(header: Text("POSTAL ADDRESS")) {
                VStack (alignment: .leading) {
                    Text(contact.addressLine1)
                    if !contact.addressLine2.isEmpty {
                          Text(contact.addressLine2)
                       }
                    Text(contact.addressCity + ", " + contact.addressState + " " + contact.addressZipcode )
                    Text(contact.addressCountry)
                }
                
            }
            
            
            
            
            
        } //end of form
        .font(.system(size: 14))
    } // view
}  //struct

struct ContactsDetail_Previews: PreviewProvider {
    static var previews: some View {
        ContactsDetail(contact: contactStructList[0])
    }
}
