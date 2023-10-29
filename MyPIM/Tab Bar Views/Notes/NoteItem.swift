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
//  NoteItem.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/20/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//  Created by Osman Balci on 5/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI
import AVFoundation

struct NoteItem: View {
    
    // Input Parameter
    let note: MultimediaNote
    
    var body: some View {
        HStack {
            if note.photoFullFilename.components(separatedBy: ".")[1] == "mp4" {
                // It is a video
                videoThumbnailImage(note: note)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            } else {
                // It is a photo
                // This public function is given in UtilityFunctions.swift
                getImageFromDocumentDirectory(filename: note.photoFullFilename.components(separatedBy: ".")[0],
                                              fileExtension: note.photoFullFilename.components(separatedBy: ".")[1],
                                              defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            }
            VStack(alignment: .leading) {
                Text(note.title)
                Text(note.locationName)
                Text(note.dateTime)
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
            
        }   // End of HStack
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
    
}

struct NoteItem_Previews: PreviewProvider {
    static var previews: some View {
        NoteItem(note: multimediaNoteStructList[0])
    }
}
