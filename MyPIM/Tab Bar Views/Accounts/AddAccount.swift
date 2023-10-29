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
//  AddAccount.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/17/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct AddAccount: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userData: UserData
    
    @State private var accountTitle = ""
    @State private var accountURL = ""
    
    
    @State private var accountUsername = ""
    @State private var accountPassword = ""
    @State private var accountNotes = ""
    @State private var accountCategorySelectedIndex = 3
    @State private var isPasswordVisible = false
    
    
    
    
    let accountCategories = ["Bank", "Computer", "CreditCard", "Other", "Email", "Membership", "Shopping"]
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        Form{
            Section(header: Text("SELECT ACCOUNT CATEGORY")) {
                VStack {
                    Picker("", selection: $accountCategorySelectedIndex) {
                        ForEach(0 ..< accountCategories.count, id: \.self) {
                            Text(accountCategories[$0])
                                .font(.headline)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }
            
            
            Section(header: Text("ACCOUNT TITLE")) {
                HStack {
                    TextField("Enter Account Title", text: $accountTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.words)
                    
                    Button(action: {    // Button to clear the text field
                        accountTitle = ""
                    }) {
                        Image(systemName: "clear")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                    }
                }   // End of HStack
            }  // end of section
            
            
            Section(header: Text("ACCOUNT URL")) {
                HStack {
                    TextField("Enter Account URL", text: $accountURL)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.words)
                    
                    Button(action: {    // Button to clear the text field
                    accountURL = ""
                    }) {
                        Image(systemName: "clear")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                    }
                }   // End of HStack
            }
            
            
            Section(header: Text("ACCOUNT USERNAME")) {
                HStack {
                    TextField("Enter Account Username", text: $accountUsername)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.words)
                    
                    Button(action: {    // Button to clear the text field
                    accountUsername = ""
                    }) {
                        Image(systemName: "clear")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                    }
                }   // End of HStack
            }
            
            
            Section(header: Text("ACCOUNT PASSWORD")) {
                HStack {
                        if isPasswordVisible {
                            SecureField("Password", text: $accountPassword)
                        } else {
                            TextField("Password", text: $accountPassword)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.blue)
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                        .transition(.move(edge: .trailing))
                    }   // End of HStack
            }
            
            
            Section(header: Text("ACCOUNT NOTES"), footer: Button(action: {
                self.dismissKeyboard()
            }) {
                Image(systemName: "keyboard")
                    .font(Font.title.weight(.light))
                    .foregroundColor(.blue)
            }
            ){
                TextEditor(text: $accountNotes)
                    .frame(height: 100)
                    .font(.custom("Helvetica", size: 14))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
            }
            
        }// end of Form
        .font(.system(size: 14))
        .navigationBarTitle(Text("New Account"), displayMode: .inline)
        // Use single column navigation view for iPhone and iPad
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarItems(trailing:
            Button(action: {
                saveNewAccountToAccounts()
                    
                    showAlertMessage = true
                    alertTitle = "Account Added!"
                    alertMessage = "New account is added to your accounts list."
                
            }) {
                Image(systemName: "plus")
        })
        
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
              Button("OK") {
                  if alertTitle == "New Account Added!" {
                      // Dismiss this view and go back to the previous view
                      dismiss()
                  }
              }
            }, message: {
              Text(alertMessage)
            })
        
    }// end of body
    /*
    -----------------------------
    MARK: Save New Account to Accountlist
    -----------------------------
    */
    func saveNewAccountToAccounts() {
       
        
        //---------------------------------------------------------------
        // Create a new instance of the Account struct and dress it up
        //---------------------------------------------------------------
        let newAccount = Accounts(id: UUID(), title: accountTitle, category: accountCategories[accountCategorySelectedIndex], url: accountURL, username: accountUsername, password: accountPassword, notes: accountNotes)
        
        userData.accountsList.append(newAccount)
        accountStructList = userData.accountsList
        accountDataChanged = true
        
        // Initialize @State variables
        accountTitle = ""
        accountURL = ""
        accountUsername = ""
        accountPassword = ""
        accountNotes = ""
        accountCategorySelectedIndex = 3
        isPasswordVisible = false
       
        
    }   // End of function
    //keyboard
    func dismissKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}

struct AddAccount_Previews: PreviewProvider {
    static var previews: some View {
        AddAccount()
    }
}
