//
//  UtilityFunctions.swift
//  PhotosVideos
//
//  Created by Osman Balci on 5/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import Foundation
import SwiftUI

// Global constant
let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

/*
***********************************************
MARK: Decode JSON file into an Array of Structs
***********************************************
*/
public func decodeJsonFileIntoArrayOfStructs<T: Decodable>(fullFilename: String, fileLocation: String, as type: T.Type = T.self) -> T {
    
    /*
     T.self defines the struct type T into which each JSON object will be decoded.
        exampleStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "exampleFile.json", fileLocation: "Main Bundle")
     or
        exampleStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "exampleFile.json", fileLocation: "Document Directory")
     The left hand side of the equation defines the struct type T into which JSON objects will be decoded.
     
     This function returns an array of structs of type T representing the JSON objects in the input JSON file.
     In Swift, an Array stores values of the same type in an ordered list. Therefore, the structs will keep their order.
     */
    
    let jsonFileData: Data?
    var jsonFileUrl: URL?
    var arrayOfStructs: T?
    
    if fileLocation == StringConstants.mainBundleName {
        // Obtain URL of the JSON file in main bundle
        let urlOfJsonFileInMainBundle: URL? = Bundle.main.url(forResource: fullFilename, withExtension: nil)
        
        if let mainBundleUrl = urlOfJsonFileInMainBundle {
            jsonFileUrl = mainBundleUrl
        } else {
            print("JSON file \(fullFilename) does not exist in main bundle!")
        }
    } else {
        // Obtain URL of the JSON file in document directory on user's device
        let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent(fullFilename)
        
        if let docDirectoryUrl = urlOfJsonFileInDocumentDirectory {
            jsonFileUrl = docDirectoryUrl
        } else {
            print("JSON file \(fullFilename) does not exist in document directory!")
        }
    }
    
    do {
        jsonFileData = try Data(contentsOf: jsonFileUrl!)
    } catch {
        print("Unable to obtain JSON file \(fullFilename) content!")
        jsonFileData = nil
    }
    
    do {
        // Instantiate an object from the JSONDecoder class
        let decoder = JSONDecoder()
        
        // Use the decoder object to decode JSON objects into an array of structs of type T
        arrayOfStructs = try decoder.decode(T.self, from: jsonFileData!)
    } catch {
        print("Unable to decode JSON file \(fullFilename)!")
    }
    
    // Return the array of structs of type T
    return arrayOfStructs!
}

/*
****************************************************************
MARK: Copy Image File from Assets.xcassets to Document Directory
****************************************************************
*/
public func copyImageFileFromAssetsToDocumentDirectory(filename: String, fileExtension: String) {
   
    /*
     UIImage(named: filename)   gets image from Assets.xcassets as UIImage
     Image("filename")          gets image from Assets.xcassets as Image
     */
   
    //--------------
    // PNG File Copy
    //--------------
   
    if fileExtension == "png" {
        if let imageInAssets = UIImage(named: filename) {
           
            // pngData() returns a Data object containing the specified image in PNG format
            if let pngImageData = imageInAssets.pngData() {
                let fileUrlInDocDir = documentDirectory.appendingPathComponent("\(filename).png")
                do {
                    try pngImageData.write(to: fileUrlInDocDir)
                } catch {
                    print("Unable to write file \(filename).png to document directory!")
                }
            } else {
                print("Image file \(filename).png cannot be converted to PNG data format!")
            }
        } else {
            print("Image file \(filename).png does not exist in Assets.xcassets!")
        }
    }
   
    //---------------
    // JPEG File Copy
    //---------------
   
    if fileExtension == "jpg" {
        if let imageInAssets = UIImage(named: filename) {
            /*
             jpegData() returns a Data object containing the specified image
             in JPEG format with 100% compression quality
             */
            if let jpegImageData = imageInAssets.jpegData(compressionQuality: 1.0) {
                let fileUrlInDocDir = documentDirectory.appendingPathComponent("\(filename).jpg")
                do {
                    try jpegImageData.write(to: fileUrlInDocDir)
                } catch {
                    print("Unable to write file \(filename).jpg to document directory!")
                }
            } else {
                print("Image file \(filename).jpg cannot be converted to JPEG data format!")
            }
        } else {
            print("Image file \(filename).jpg does not exist in Assets.xcassets!")
        }
    }
}

/*
***************************************
MARK: Get Image from Document Directory
***************************************
*/
public func getImageFromDocumentDirectory(filename: String, fileExtension: String, defaultFilename: String) -> Image {
 
    var imageData: Data?
   
    let urlOfImageInDocDir = documentDirectory.appendingPathComponent("\(filename).\(fileExtension)")
       
    do {
        // Try to get the image data from urlOfImageInDocDir
        imageData = try Data(contentsOf: urlOfImageInDocDir, options: NSData.ReadingOptions.mappedIfSafe)
    } catch {
        imageData = nil
    }
   
    // Unwrap imageData to see if it has a value
    if let imageDataObtained = imageData {
       
        // Create a UIImage object from imageDataObtained
        let uiImage = UIImage(data: imageDataObtained)
       
        // Unwrap uiImage to see if it has a value
        if let imageObtained = uiImage {
            // Convert UIImage to Image and return
            return Image(uiImage: imageObtained)
        } else {
            return Image(defaultFilename)
        }
    } else {
        /*
         Image file with name 'defaultFilename' is returned if the image with 'filename'
         cannot be obtained. Image file 'defaultFilename' must be given in Assets.xcassets
         */
        return Image(defaultFilename)
    }
}

/*
********************************
MARK: Get Image from Binary Data
********************************
*/
public func getImageFromBinaryData(binaryData: Data?, defaultFilename: String) -> Image {
    
    // Create a UIImage object from binaryData
    let uiImage = UIImage(data: binaryData!)
    
    // Unwrap uiImage to see if it has a value
    if let imageObtained = uiImage {
        
        // Image is successfully obtained
        return Image(uiImage: imageObtained)
        
    } else {
        /*
         Image file with name 'defaultFilename' is returned if the image cannot be obtained
         from binaryData given. Image file 'defaultFilename' must be given in Assets.xcassets
         */
        return Image(defaultFilename)
    }
}

/*
******************************************************
MARK: Copy File from Main Bundle to Document Directory
******************************************************
*/

enum FileLoadingError: Error {
    case fileNotExist
    case failedToCopy
}


func copyFileFromMainBundleToDocumentDirectory(filename: String, fileExtension: String) throws {
    
    guard let fileUrlInMainBundle = Bundle.main.url(forResource: filename, withExtension: fileExtension) else {
        print("The file \(filename).\(fileExtension) does not exist in main bundle!")
        throw FileLoadingError.fileNotExist
    }
    
    let fileUrlInDocDir = documentDirectory.appendingPathComponent("\(filename).\(fileExtension)")
    
    do {
        try FileManager.default.copyItem(at: fileUrlInMainBundle, to: fileUrlInDocDir)
    } catch {
        print("Unable to copy file \(filename).\(fileExtension) from main bundle to document directory!")
    }

}


enum StringConstants {
    static let mainBundleName = "Main Boundle"
}
