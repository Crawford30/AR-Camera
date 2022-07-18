//
//  CDMediaObject+CoreDataProperties.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/18/22.
//
//

import Foundation
import CoreData


extension CDMediaObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMediaObject> {
        return NSFetchRequest<CDMediaObject>(entityName: "CDMediaObject")
    }

    @NSManaged public var id: String?
    @NSManaged public var createDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var caption: String?
    @NSManaged public var videoData: Data?

}

extension CDMediaObject : Identifiable {

}
