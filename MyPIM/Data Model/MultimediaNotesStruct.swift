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
//  NotesStruct.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/20/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct MultimediaNote: Hashable, Codable, Identifiable {
    
    var id: UUID
    var title: String
    var textualNote: String
    var photoFullFilename: String
    var audioFullFilename: String
    var speechToTextNote: String
    var locationName: String
    var dateTime: String
    var latitude: Double
    var longitude: Double
    
}

/*
 {
     "id": "77D31185-8F9D-4A1B-86EE-E08059081E93",
     "title": "Amsterdam Visit Notes",
     "textualNote": "Amsterdam has 165 canals. The tilted houses are called Dancing Houses. Amsterdam has more bridges than Venice. Magere Brug is the most famous bridge. There are 2500 houseboats in Amsterdam.",
     "photoFullFilename": "254B32EE-7870-431D-8637-1E28B769135A.jpg",
     "audioFullFilename": "C35DB12E-3405-46BD-9FFA-9179C3BC7F80.m4a",
     "speechToTextNote": "Amsterdam is the Netherlands’ capital, known for its artistic heritage, elaborate canal system and narrow houses with gabled facades, legacies of the city’s 17th-century Golden Age.",
     "locationName": "Amsterdam, Netherlands",
     "dateTime": "2023-01-10 at 15:36:21",
     "latitude": 52.370216,
     "longitude": 4.895168
 },
 */
