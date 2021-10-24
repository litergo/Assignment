//
//  SportEventMO+CoreDataProperties.swift
//  
//
//  Created by 19336844 on 22.10.2021.
//
//

import Foundation
import CoreData


extension SportEventMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SportEventMO> {
        return NSFetchRequest<SportEventMO>(entityName: "SportEventMO")
    }

    @NSManaged public var name: String?
    @NSManaged public var venue: String?
    @NSManaged public var duration: Int32

}
