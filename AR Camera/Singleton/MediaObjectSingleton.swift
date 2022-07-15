//
//  MediaObjectSingleton.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/15/22.
//

import UIKit


class MediaObjectSingleton {
    static let shared = MediaObjectSingleton()
    private var tag:  String
    private var createdAtDate: Date
    
    private  init() { //A  private initilaizer, means it can only be called this class
        tag = ""
        createdAtDate = Date()
    } //not to be accessed anywhere apart from this class
    

    func setUserTag(theTag: String) -> () {
        tag = theTag
    }
    
    func getUserTag() -> String {
        return tag
    }
    
    func setCreatedAtDate(theDate: Date) -> () {
        createdAtDate = theDate
    }
    
    func getCreatedAtDate() -> Date {
        return createdAtDate
    }
    
    
    
}
