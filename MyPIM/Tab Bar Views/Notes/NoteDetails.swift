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
//  NoteDetails.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/20/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//  Created by Osman Balci on 6/7/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI
import MapKit
import AVKit
import AVFoundation


struct NoteDetails: View {
    
    // Input Parameter
    let note: MultimediaNote
    @EnvironmentObject var audioPlayer: AudioPlayer
    
    @State private var selectedMapTypeIndex = 0
    var mapTypes = ["Standard", "Satellite", "Hybrid", "Globe"]
    
    
    
    @State private var speechConvertedToText = ""
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            
                Section(header: Text("MULTIMEDIA NOTE TITLE")) {
                    Text(note.title)
                }
                
                Section(header: Text("MULTIMEDIA NOTE PHOTO")) {
                    // This public function is given in UtilityFunctions.swift
                    getImageFromDocumentDirectory(filename: note.photoFullFilename.components(separatedBy: ".")[0],
                                                  fileExtension: note.photoFullFilename.components(separatedBy: ".")[1],
                                                  defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                        .contextMenu {
                            // Context Menu Item
                            Button(action: {
                                // Copy the photo from the file in document directory to universal clipboard for pasting elsewhere
                                UIPasteboard.general.image = UIImage(contentsOfFile: documentDirectory.appendingPathComponent(note.photoFullFilename).path)
                                
                                showAlertMessage = true
                                alertTitle = "Photo is Copied to Clipboard"
                                alertMessage = "You can paste it on your iPhone, iPad, Mac laptop or Mac desktop each running under your Apple ID"
                            }) {
                                Image(systemName: "doc.on.doc")
                                Text("Copy Photo")
                            }
                        }
                }
                
                
                Section(header: Text("TEXTUAL NOTE")) {
                    Text(note.textualNote)
                }
                
                Section(header: Text("NAME OF LOCATION WHERE NOTE WAS TAKEN")) {
                    Text(note.locationName)
                }
                
                
                
          
            
            
            

            Section(header: Text("SHOW MULTIMEDIA NOTE PHOTO LOCATION ON MAP")) {
                
                NavigationLink(destination: photoLocationOnMap) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                        Text("Show Photo Location on Map")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
            }
            
            Section(header: Text("Play Voice Memo")) {
                Button(action: {
                    if audioPlayer.isPlaying {
                        audioPlayer.pauseAudioPlayer()
                    } else {
                        audioPlayer.startAudioPlayer()
                    }
                }) {
                    HStack {
                        Image(systemName: audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                        Text("Play Voice Memo")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
            } //end of  play voice memo
            
            Section(header: Text("SPEECH TO TEXT NOTE")) {

                Text(note.speechToTextNote)
            }
            
            Section(header: Text("DATE AND TIME WHEN NOTE WAS TAKEN")) {
                Text(note.dateTime)
            }
            
            
        }   // End of Form
        .navigationBarTitle(Text(note.title), displayMode: .inline)
        .font(.system(size: 14))
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
              Button("OK") {}
            }, message: {
              Text(alertMessage)
            })
    }   // End of body var
    
    var photoLocationOnMap: some View {
        
        var mapType: MKMapType
       
        mapType = MKMapType.standard
        
        return AnyView(
            MapView(mapType: mapType,
                    latitude: note.latitude,
                    longitude: note.longitude,
                    delta: 15.0,
                    deltaUnit: "degrees",
                    annotationTitle: note.title,
                    annotationSubtitle: note.dateTime)
            
                .navigationBarTitle(Text(note.title), displayMode: .inline)
            )
    }
    
    func videoThumbnailImage(note: MultimediaNote) -> Image {
        
        let urlOfVideoInDocDir = documentDirectory.appendingPathComponent("\(note.photoFullFilename)")
        
        let urlAsset = AVURLAsset(url: urlOfVideoInDocDir, options: nil)
        let assetImageGenerator = AVAssetImageGenerator(asset: urlAsset)
        assetImageGenerator.appliesPreferredTrackTransform = true
        assetImageGenerator.apertureMode = .encodedPixels

        let cmTime = CMTime(seconds: 0, preferredTimescale: 60)
        let thumbnailCGImage: CGImage
        do {
            thumbnailCGImage = try assetImageGenerator.copyCGImage(at: cmTime, actualTime: nil)
        } catch let error {
            print("Error: \(error)")
            return Image("ImageUnavailable")
        }

        let uiImage = UIImage(cgImage: thumbnailCGImage)
        
        return Image(uiImage: uiImage)
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
}

struct NoteDetails_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetails(note: multimediaNoteStructList[0])
    }
}
