
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
 *///
//  AddContact.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/17/23.
//  Created by Osman Balci on 5/25/22.
//

import SwiftUI

struct AddContact: View {
    // Enable this view to be dismissed to go back to the previous view
    @Environment(\.dismiss) private var dismiss
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    @State private var contactFirstName = ""
    @State private var contactLastName = ""
    @State private var contactCompanyName = ""
    @State private var contactPhoneNumber = ""
    @State private var contactEmailAddress = ""
    @State private var contactAddressLine1 = ""
    @State private var contactAddressLine2 = ""
    @State private var contactCityName = ""
    @State private var contactState = ""
    @State private var contactZipCode = ""
    @State private var contactCountryName = ""
    
    @State private var showImagePicker = false
    @State private var pickedUIImage: UIImage?
    @State private var pickedImage: Image?
    
    @State private var useCamera = false
    @State private var usePhotoLibrary = true
    
    
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        
        let camera = Binding(
            get: { useCamera },
            set: {
                useCamera = $0
                if $0 == true {
                    usePhotoLibrary = false
                }
            }
        )
        let photoLibrary = Binding(
            get: { usePhotoLibrary },
            set: {
                usePhotoLibrary = $0
                if $0 == true {
                    useCamera = false
                }
            }
        )
        
        
        Form {
            
            Group{
                Section(header: Text("TAKE OR PICK PHOTO")) {
                    VStack {
                        Toggle("Use Camera", isOn: camera)
                        Toggle("Use Photo Library", isOn: photoLibrary)
                        
                        Button("Get Photo") {
                            showImagePicker = true
                        }
                        .tint(.blue)
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        
                    }
                }
                if pickedImage != nil {
                    Section(header: Text("CONTACT PHOTO")) {
                        pickedImage?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100.0, height: 100.0)
                    }
                }
                else{
                    Section(header: Text("MULTIMEDIA NOTE PHOTO")) {
                        Image("DefaultContactPhoto")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100.0, height: 100.0)
                    }
                }
                
                Section(header: Text("FIRST NAME")) {
                    HStack {
                        TextField("Enter First Name", text: $contactFirstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        
                        Button(action: {    // Button to clear the text field
                            contactFirstName = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                }
                
                Section(header: Text("LAST NAME")) {
                    HStack {
                        TextField("Enter Last Name", text: $contactLastName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        
                        Button(action: {    // Button to clear the text field
                            contactLastName = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                }
                
                Section(header: Text("COMPANY NAME")) {
                    HStack {
                        TextField("Enter Company Name", text: $contactCompanyName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        
                        Button(action: {    // Button to clear the text field
                            contactCompanyName = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                }
            }
            Group{
                Section(header: Text("PHONE NUMBER")) {
                    HStack {
                        Image(systemName: "phone.circle")
                            .font(.system(size: 24))
                        TextField("Enter Phone Number", text: $contactPhoneNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        
                        Button(action: {    // Button to clear the text field
                            contactPhoneNumber = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                }
                
                Section(header: Text("EMAIL ADDRESS")) {
                    HStack {
                        Image(systemName: "envelope")
                            .font(.system(size: 24))
                        TextField("Enter Email Address", text: $contactEmailAddress)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        
                        Button(action: {    // Button to clear the text field
                            contactEmailAddress = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                }
                
                Section(header: Text("ADDRESS LINE 1")) {
                    HStack {
                        TextField("Enter Address Line 1", text: $contactAddressLine1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        
                        Button(action: {    // Button to clear the text field
                            contactAddressLine1 = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                }
                
                Section(header: Text("ADDRESS LINE 2 (OPTIONAL)")) {
                    HStack {
                        TextField("Enter Address Line 2", text: $contactAddressLine2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        
                        Button(action: {    // Button to clear the text field
                            contactAddressLine2 = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                }
                
                Section(header: Text("CITY NAME")) {
                    HStack {
                        TextField("Enter City Name", text: $contactCityName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        
                        Button(action: {    // Button to clear the text field
                            contactCityName = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                }
                
                Section(header: Text("STATE (OPTIONAL FOR NON-USA ADDRESSES)")) {
                    HStack {
                        TextField("Enter State", text: $contactState)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        
                        Button(action: {    // Button to clear the text field
                            contactState = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                }
            }
            Group{
                Section(header: Text("ZIP CODE")) {
                    HStack {
                        TextField("Enter Zip Code", text: $contactZipCode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        
                        Button(action: {    // Button to clear the text field
                            contactZipCode = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                }
                
                Section(header: Text("COUNRTY NAME")) {
                    HStack {
                        TextField("Enter Country Name", text: $contactCountryName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        
                        Button(action: {    // Button to clear the text field
                            contactCountryName = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                }
            }
        }
        .font(.system(size: 14))
        .navigationBarTitle(Text("New Contact"), displayMode: .inline)
        // Use single column navigation view for iPhone and iPad
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarItems(trailing:
                                Button(action: {
            saveNewContactToContacts()
            
            showAlertMessage = true
            alertTitle = "Contact Added!"
            alertMessage = "New contact is added to your contacts list."
            
        }) {
            Image(systemName: "plus")
        })
        .onChange(of: pickedUIImage) { _ in
            guard let uiImagePicked = pickedUIImage else { return }
            
            pickedImage = Image(uiImage: uiImagePicked)
        }
        .sheet(isPresented: $showImagePicker) {
            
            
            ImagePicker(uiImage: $pickedUIImage, sourceType: useCamera ? .camera : .photoLibrary, imageWidth: 500.0, imageHeight: 281.25)
        }
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
            Button("OK") {
                if alertTitle == "New Contact Added!" {
                    // Dismiss this view and go back to the previous view
                    dismiss()
                }
            }
        }, message: {
            Text(alertMessage)
        })
        
    }
    
    /*
    -----------------------------
    MARK: Save New Contact to Contacts
    -----------------------------
    */
    func saveNewContactToContacts() {
        
        
        
        //--------------------------------------------------
        // Store Taken or Picked Photo to Document Directory
        //--------------------------------------------------
        let photoFullFilename = UUID().uuidString + ".jpg"

        /*
         Convert pickedUIImage to a data object containing the
         image data in JPEG format with 100% compression quality
         */
        if let data = pickedUIImage!.jpegData(compressionQuality: 1.0) {
            let fileUrl = documentDirectory.appendingPathComponent(photoFullFilename)
            try? data.write(to: fileUrl)
        } else {
            print("Unable to write photo image to document directory!")
        }
        
        //---------------------------------------------------------------
        // Create a new instance of the Contact struct and dress it up
        //---------------------------------------------------------------
        let newContact = Contacts(id: UUID(),
                                       firstName: contactFirstName,
                                        lastName: contactLastName,
                                       
                                  photoFullFilename: photoFullFilename,
                                       company: contactCompanyName,
                                  phone: contactPhoneNumber,
                                  email: contactEmailAddress,
                                  addressLine1: contactAddressLine1,
                                  addressLine2: contactAddressLine2,
                                  addressCity: contactCityName,
                                  addressState: contactState,
                                  addressZipcode: contactZipCode,
                                  addressCountry: contactCountryName
                                  
        )
        
        // Append the new photo to photosList
        userData.contactsList.append(newContact)
        
        // Set the global variable point to the changed list
        contactsStructList = userData.contactsList
        
        let selectedContactAttributesForSearch =
        "\(newContact.id)|\(newContact.firstName)|\(newContact.lastName)|\(newContact.photoFullFilename)|\(newContact.company)|\(newContact.phone)|\(newContact.email)|\(newContact.addressLine1)|\(newContact.addressLine2)|\(newContact.addressCity)|\(newContact.addressState)|\(newContact.addressZipcode)|\(newContact.addressCountry)"
        
        userData.searchableOrderedContactList.append(selectedContactAttributesForSearch)
        
        orderedSearchableContactList = userData.searchableOrderedContactList
        
        
        // Set global flag defined in AlbumPhotosData
        contactsDataChanged = true
        
        // Initialize @State variables
        showImagePicker = false
        pickedUIImage = nil
        contactFirstName = ""
        contactLastName = ""
        contactCompanyName = ""
        contactPhoneNumber = ""
        contactEmailAddress = ""
        contactAddressLine1 = ""
        contactAddressLine2 = ""
        contactCityName = ""
        contactState = ""
        contactZipCode = ""
        contactCountryName = ""
        
    }
    
}
struct AddContact_Previews: PreviewProvider {
    static var previews: some View {
        AddContact()
    }
}
