//
//  Log+CoreDataProperties.swift
//  
//
//  Created by MBG on 11/20/17.
//
//

import Foundation
import CoreData


extension Log {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Log> {
        return NSFetchRequest<Log>(entityName: "Log")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: String?
    @NSManaged public var category: String?
    @NSManaged public var detail: String?

}
