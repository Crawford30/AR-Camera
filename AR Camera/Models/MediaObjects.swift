//
//  MediaObjects.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/15/22.
//

import Foundation
class MediaObject: NSObject, NSCoding {
 
    var imageData: Data?
    var videoURL: URL?
    var caption: String?
    var id = UUID().uuidString
    var createDate:Date?
    var endDate:Date?
    
    init( videoURL: URL, caption: String, id: String, createDate: Date, endDate: Date ) {
        //self.imageData = imageData
        self.videoURL = videoURL
        self.caption = caption
        self.id = UUID().uuidString
        self.createDate = createDate
        self.endDate = endDate
    }
    
    required init(coder decoder: NSCoder) {
       //self.imageData = decoder.decodeObject(forKey: "imageData") as? Data ?? NSData() as Data
        self.videoURL = decoder.decodeObject(forKey: "videoURL") as? URL ?? NSURL() as URL
        self.caption = decoder.decodeObject(forKey: "caption") as? String ?? ""
        self.id = decoder.decodeObject(forKey: "id") as? String ?? ""
        self.createDate = decoder.decodeObject(forKey: "createDate") as? Date ?? Date()
        self.endDate = decoder.decodeObject(forKey: "endDate") as? Date ?? Date()
    }
    
    func encode(with coder: NSCoder) {
        //coder.encode(imageData, forKey: "imageData")
        coder.encode(videoURL, forKey: "videoURL")
        coder.encode(caption, forKey: "caption")
        coder.encode(id, forKey: "id")
        coder.encode(createDate, forKey: "createDate")
        coder.encode(endDate, forKey: "endDate")
    }
}

//struct MediaObject: Codable {
//    let imageData: Data?
//    let videoURL: URL?
//    let caption: String?
//    var id = UUID().uuidString
//    let createDate:Date?
//    let endDate:Date?
//}



