//
//  MediaObjects.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/15/22.
//

import Foundation

struct MediaObject {
    let imageData: Data?
    let videoURL: String?
    let caption: String?
    let id = UUID().uuidString
    let createDate = Date()
    let endDate:Date?
}
