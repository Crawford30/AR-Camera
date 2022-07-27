//
//  CoreDataManager.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/18/22.
//

import UIKit
import CoreData

class CoreDataManager{
    //Creating Singleton
    private init() { }
    
    static   let shared = CoreDataManager()
    private var mediaObjects = [CDMediaObject]()
    
    //Get Instance of NSManagedObject from the AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //NSManagedObject does saving, fetching on NSManagedObject
    
    //CRUD -Create
    func createMediaObject(videoURL: URL?, caption:String?, createDate: Date?, endDate: Date?)  -> CDMediaObject {
        let mediaObject  = CDMediaObject(entity: CDMediaObject.entity(), insertInto: context)
        
        mediaObject.id = UUID().uuidString
        //        mediaObject.imageData = imageData
        if let caption = caption {
            mediaObject.caption = caption
        }
        if let createDate = createDate {
            mediaObject.createDate = createDate
        }
        
        if let endDate = endDate {
            mediaObject.endDate = endDate
        }
        
        if let videoURL = videoURL { //if it exists, means its a video object
            //convert URL to Data
            do {
                try  mediaObject.videoData =  Data(contentsOf: videoURL)
            } catch {
                print("Failed to convert URL to Data: \(error)")
            }
        }
        
        //save the created object
        do {
            try context.save()
        } catch {
            print("Failed to save the newly created media object with error: \(error)")
        }
        return mediaObject
    }
    
    //=======Read========
    func fetchMediaObjects() -> [CDMediaObject]  {
        do {
            mediaObjects  = try context.fetch(CDMediaObject.fetchRequest())
        } catch {
            print("Failed to fetch media objects: \(error)")
        }
        return mediaObjects
    }
    
    //Update
    
    //Delete
    
    public func deleteMediaObject(_ mediaObject: CDMediaObject) {
        context.delete(mediaObject)
        do {
            try context.save()
        } catch {
            print("failed to delete object with error: \(error)")
        }
        
    }
    
    
    
    
    public  func update(identifier: String,tag:String) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CDMediaObject")
        let predicate = NSPredicate(format: "id = '\(identifier)'")
        fetchRequest.predicate = predicate
        do
        {
            let object = try context.fetch(fetchRequest)
            if object.count == 1
            {
                let objectUpdate = object.first as! NSManagedObject
                objectUpdate.setValue(tag, forKey: "caption")
                do{
                    try context.save()
                }
                catch
                {
                    print(error)
                }
            }
        }
        catch
        {
            print(error)
        }
    }
    
    
    
    
}
