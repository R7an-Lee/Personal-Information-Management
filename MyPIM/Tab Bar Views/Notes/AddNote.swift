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
//  AddNote.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/20/23.
//  Created by Osman Balci on 6/13/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI
import AVFoundation
fileprivate var audioRecorder: AVAudioRecorder!
fileprivate var audioFullFilename = ""
fileprivate var startTime: Double = 0
struct AddNote: View {

    // Enable this view to be dismissed to go back to the previous view
    @Environment(\.dismiss) private var dismiss
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    @State private var recordingVoice = false
    
    @State private var speechConvertedToText = ""
    
    @State private var voiceRecordingDuration = ""
    
    //-----------------
    // Photo Attributes
    //-----------------
    @State private var photoTitleTextFieldValue = ""
    @State private var noteTextualTextFieldValue = ""
    @State private var locationNameFieldValue = ""
    
    @State private var photoCategorySelectedIndex = 4
    @State private var photoRatings = [1, 2, 3, 4, 5]
    @State private var photoRatingSelectedIndex = 0
    
    // Array of album photo categories
    let photoCategories = ["Boys-Only Trip", "Business Trip", "Conference Trip", "Family Vacation", "Friends-Only Trip", "Girls-Only Trip", "Package Tour", "Siblings-Only Trip", "Volunteer Trip"]
    
    //------------------------------------
    // Image Picker from Camera or Library
    //------------------------------------
    @State private var showImagePicker = false
    @State private var pickedUIImage: UIImage?
    @State private var pickedImage: Image?
    
    @State private var useCamera = false
    @State private var usePhotoLibrary = true
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        /*
         Create Binding between 'useCamera' and 'usePhotoLibrary' boolean @State variables so that only one of them can be true.
         get
            A closure that retrieves the binding value. The closure has no parameters.
         set
            A closure that sets the binding value. The closure has the following parameter:
            newValue stored in $0: The new value of 'useCamera' or 'usePhotoLibrary' boolean variable as true or false.
         
         Custom get and set closures are run when a newValue is obtained from the Toggle when it is turned on or off.
         */
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
            Section(header: Text("MULTIMEDIA NOTE TITLE")) {
                HStack {
                    TextField("Enter Note Title", text: $photoTitleTextFieldValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.words)
                    
                    Button(action: {    // Button to clear the text field
                        photoTitleTextFieldValue = ""
                    }) {
                        Image(systemName: "multiply.circle")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                    }
                }   // End of HStack
            }  //end of photo title
            
            Section(header: Text("TAKE NOTES BY ENTERING TEXT"), footer:
                                    Button(action: {
                                        self.dismissKeyboard()
                                    }) {
                                        Image(systemName: "keyboard")
                                            .font(Font.title.weight(.light))
                                            .foregroundColor(.blue)
                                    }
                        ) {
                            TextEditor(text: $noteTextualTextFieldValue)
                                .frame(height: 100)
                                .font(.custom("Helvetica", size: 14))
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                        }
            
            
            
            Section(header: Text("MULTIMEDIA NOTE PHOTO")) {
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
                Section(header: Text("ADD MULTIMEDIA NOTE PHOTO")) {
                    pickedImage?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100.0, height: 100.0)
                }
            }
            
            Section(header: Text("Voice Recording")) {
                Button(action: {
                    voiceRecordingMicrophoneTapped()
                }) {
                    voiceRecordingMicrophoneLabel
                }
            }
            
            Section(header: Text("TAKE NOTES BY CONVERTING YOUR SPEECH TO TEXT")) {
                HStack {
                    Spacer()
                    Button(action: {
                        microphoneTapped()
                    }) {
                        microphoneLabel
                    }
                    Spacer()
                    Text(speechConvertedToText)
                        .multilineTextAlignment(.center)
                        // This enables the text to wrap around on multiple lines
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                }
                
            }
            
            
            
            Section(header: Text("MULTIMEDIA NOTE LOCATION NAME")) {
                HStack {
                    TextField("Enter Location Name", text: $locationNameFieldValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.words)
                    
                    Button(action: {    // Button to clear the text field
                        locationNameFieldValue = ""
                    }) {
                        Image(systemName: "multiply.circle")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                    }
                }   // End of HStack
            }  //end of location name
            
            /*
            Section(header: Text("Select Photo Category")) {
                VStack {    // Enclose within VStack so that Picker is centered
                    Picker("", selection: $photoCategorySelectedIndex) {
                        ForEach(0 ..< photoCategories.count, id: \.self) {
                            Text(photoCategories[$0])
                                .font(.headline)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            } //end of photo category
             */
            /*
            Section(header: Text("Select Photo Rating")) {
                VStack {    // Enclose within VStack so that Picker is centered
                    Picker("", selection: $photoRatingSelectedIndex) {
                        ForEach(0 ..< photoRatings.count, id: \.self) {
                            Text(String(photoRatings[$0]))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            } //end of photo rating
             */
        }   // End of Form
        .font(.system(size: 14))
        .navigationBarTitle(Text("New Multimedia Note"), displayMode: .inline)
        // Use single column navigation view for iPhone and iPad
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarItems(trailing:
            Button(action: {
                if inputDataValidated() {
                    saveNewPhotoToAlbum()
                    
                    showAlertMessage = true
                    alertTitle = "New Photo Added!"
                    alertMessage = "New photo is successfully added to your album."
                } else {
                    showAlertMessage = true
                    alertTitle = "Missing Input Data!"
                    alertMessage = "Photo must be taken or picked with a title.\nCategory and Rating defaults are used if not selected."
                }
            }) {
                Text("Save")
        })
        .onChange(of: pickedUIImage) { _ in
            guard let uiImagePicked = pickedUIImage else { return }
            
            // Convert UIImage to SwiftUI Image
            pickedImage = Image(uiImage: uiImagePicked)
        }
        .sheet(isPresented: $showImagePicker) {
            /*
             For storage and performance efficiency reasons, we scale down the photo image selected from the
             photo library or taken by the camera to a smaller size with imageWidth and imageHeight in points.
             
             For retina displays, 1 point = 3 pixels
             
             // Example: For HD aspect ratio of 16:9
             width  = 500.00 points --> 1500.00 pixels
             height = 281.25 points -->  843.75 pixels
             
             500/281.25 = 16/9 = 1500.00/843.75 = HD aspect ratio
             
             imageWidth =  500.0 points and imageHeight = 281.25 points will produce an image with
             imageWidth = 1500.0 pixels and imageHeight = 843.75 pixels which is about 600 KB in JPG format.
             */
            
            ImagePicker(uiImage: $pickedUIImage, sourceType: useCamera ? .camera : .photoLibrary, imageWidth: 500.0, imageHeight: 281.25)
        }
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
              Button("OK") {
                  if alertTitle == "New Photo Added!" {
                      // Dismiss this view and go back to the previous view
                      dismiss()
                  }
              }
            }, message: {
              Text(alertMessage)
            })
        
    }   // End of body var
    
    /*
     ------------------------------------
     MARK: Voice Recording Duration Timer
     ------------------------------------
     */
    func durationTimer() {
        
        // Schedule a timer that repeats every 0.01 second
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            
            if recordingVoice {

                // Calculate total time since timer started in seconds
                var timeElapsed = Date().timeIntervalSinceReferenceDate - startTime
                
                // Calculate hours
                let timerHours = UInt8(timeElapsed / 3600)
                timeElapsed = timeElapsed - (TimeInterval(timerHours) * 3600)
                
                // Calculate minutes
                let timerMinutes = UInt8(timeElapsed / 60.0)
                timeElapsed = timeElapsed - (TimeInterval(timerMinutes) * 60)
                
                // Calculate seconds
                let timerSeconds = UInt8(timeElapsed)
                timeElapsed = timeElapsed - TimeInterval(timerSeconds)
                
                // Calculate milliseconds
                let timerMilliseconds = UInt8(timeElapsed * 100)
                
                // Create the time string and update the label
                let timeString = String(format: "%02d:%02d:%02d.%02d", timerHours, timerMinutes, timerSeconds, timerMilliseconds)
                
                voiceRecordingDuration = timeString
                
            } else {
                timer.invalidate()      // Stop the timer
            }
        }
    }
    
    /*
     --------------------------------------
     MARK: Voice Recording Microphone Label
     --------------------------------------
     */
    var voiceRecordingMicrophoneLabel: some View {
        VStack {
            Image(systemName: recordingVoice ? "mic.fill" : "mic.slash.fill")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.blue)
                .padding()
            Text(recordingVoice ? "Recording your voice... Tap to Stop!" : "Start Recording!")
                .multilineTextAlignment(.center)
        }
    }
    
    /*
     ---------------------------------------
     MARK: Voice Recording Microphone Tapped
     ---------------------------------------
     */
    func voiceRecordingMicrophoneTapped() {
        if audioRecorder == nil {
            recordingVoice = true
            startRecording()
        } else {
            recordingVoice = false
            finishRecording()
        }
    }
    
    /*
     ---------------------------
     MARK: Start Voice Recording
     ---------------------------
     */
    func startRecording() {
        
        // Time at which the voice recording duration timer starts
        startTime = Date().timeIntervalSinceReferenceDate
        durationTimer()

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        audioFullFilename = UUID().uuidString + ".m4a"
        let audioFilenameUrl = documentDirectory.appendingPathComponent(audioFullFilename)
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilenameUrl, settings: settings)
            audioRecorder.record()
        } catch {
            finishRecording()
        }
    }
    
    /*
     ----------------------------
     MARK: Finish Voice Recording
     ----------------------------
     */
    func finishRecording() {
        audioRecorder.stop()
        audioRecorder = nil
        recordingVoice = false
        durationTimer()
    }
    
    /*
     ---------------------------
     MARK: Input Data Validation
     ---------------------------
     */
    func inputDataValidated() -> Bool {
        
        // Remove spaces, if any, at the beginning and at the end of the entered photo title
        let photoTitle = photoTitleTextFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        /*
         Photo must be taken or picked with a title.
         Category and Rating defaults are used if not selected.
         */
        if photoTitle.isEmpty || pickedImage == nil {
            return false
        }
        return true
    }
    
    //dismiss keyboard function
    func dismissKeyboard() {

            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

        }
    
    
    /*
     ---------------------
     MARK: Supporting View
     ---------------------
     */
    var microphoneLabel: some View {
        VStack {
            Image(systemName: recordingVoice ? "mic.fill" : "mic.slash.fill")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.blue)
            Text(recordingVoice ? "Recording your voice... Tap to Stop!" : "Convert Speech to Text!")
                .padding()
                .multilineTextAlignment(.center)
        }
    }
    
    /*
     -----------------------
     MARK: Microphone Tapped
     -----------------------
     */
    func microphoneTapped() {
        if recordingVoice {
            cancelRecording()
            recordingVoice = false
        } else {
            recordingVoice = true
            recordAndRecognizeSpeech()
        }
    }
    
    /*
     ----------------------
     MARK: Cancel Recording
     ----------------------
     */
    func cancelRecording() {
        request.endAudio()
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        recognitionTask.finish()
    }
    
    /*
     --------------------------------------------
     MARK: Record Audio and Transcribe it to Text
     --------------------------------------------
     */
    func recordAndRecognizeSpeech() {
        //--------------------
        // Set up Audio Buffer
        //--------------------
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }
        
        //---------------------
        // Prepare Audio Engine
        //---------------------
        audioEngine.prepare()
        
        //-------------------
        // Start Audio Engine
        //-------------------
        do {
            try audioEngine.start()
        } catch {
            print("Unable to start Audio Engine!")
            return
        }
        
        //-------------------------------
        // Convert recorded voice to text
        //-------------------------------
        recognitionTask = speechRecognizer.recognitionTask(with: request, resultHandler: { result, error in
            
            if result != nil {  // check to see if result is empty (i.e. no speech found)
                if let resultObtained = result {
                    let bestString = resultObtained.bestTranscription.formattedString
                    speechConvertedToText = bestString
                    
                } else if let error = error {
                    print("Transcription failed, but will continue listening and try to transcribe. See \(error)")
                }
            }
        })
    } //end of function
    
    


    
    /*
    -----------------------------
    MARK: Save New Photo to Album
    -----------------------------
    */
    func saveNewPhotoToAlbum() {
        
        //-----------------------------
        // Obtain Current Date and Time
        //-----------------------------
        let date = Date()
        
        // Instantiate a DateFormatter object
        let dateFormatter = DateFormatter()

        // Set the date format to yyyy-MM-dd at HH:mm:ss
        dateFormatter.dateFormat = "yyyy-MM-dd' at 'HH:mm:ss"
        
        // Format current date and time as above and convert it to String
        let currentDateTime = dateFormatter.string(from: date)
        
        //----------------------------------------------------------
        // Get Latitude and Longitude of Where Photo Taken or Picked
        //----------------------------------------------------------
        
        // Public function currentLocation() is given in CurrentLocation.swift
        let photoLocation = currentLocation()
        
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
        // Create a new instance of the AlbumPhoto struct and dress it up
        //---------------------------------------------------------------
        let newNote = MultimediaNote(id: UUID(),
                                       title: photoTitleTextFieldValue,
                                       textualNote: noteTextualTextFieldValue,
                                       photoFullFilename: photoFullFilename,
                                       audioFullFilename: audioFullFilename, speechToTextNote: speechConvertedToText,
                                       locationName: locationNameFieldValue,
                                       dateTime: currentDateTime,
                                       latitude: photoLocation.latitude,
                                       longitude: photoLocation.longitude)
        
        // Append the new photo to photosList
        userData.notesList.append(newNote)
        
        // Set the global variable point to the changed list
        multimediaNoteStructList = userData.notesList
        
        // Set global flag defined in AlbumPhotosData
        noteDataChanged = true
        
        // Initialize @State variables
        showImagePicker = false
        pickedUIImage = nil
        photoTitleTextFieldValue = ""
        photoCategorySelectedIndex = 4
        
    }   // End of function
    
}   // End of struct

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote()
    }
}



