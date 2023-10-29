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
//  AccountsDetails.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/17/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//


import SwiftUI

struct AccountsDetail: View {
    
    let account: Accounts
    var body: some View {
        Form {
            Section(header: Text("ACCOUNT TITLE")) {
                Text(account.title)
            }
            
            Section(header: Text("CATEGORY")) {
                HStack{
                    Image(account.category)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0, height: 100.0)
                    Text(account.category + " Account")
                    
                }
            }
            
            Section(header: Text("SHOW ACCOUNT WEBSITE")) {
                // Tap the website URL to display the website externally in default web browser
                Link(destination: URL(string: account.url)!) {
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                        Text("Show Account Website")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
            }
            
            Section(header: Text("ACCOUNT USERNAME")) {
                Text(account.username)
            }
            
            Section(header: Text("ACCOUNT PASSWORD")) {
                Text(account.password)
            }
            
            Section(header: Text("ACCOUNT NOTES")) {
                Text(account.notes)
            }
            
        }// end of form
        .font(.system(size: 14))
    }  //end of view
} //struct

struct AccountsDetail_Previews: PreviewProvider {
    static var previews: some View {
        AccountsDetail(account: accountStructList[0])
    }
}
