//
//  TaskCoreData+CoreDataProperties.swift
//  
//
//  Created by Анастасия Чупова on 29.06.2021.
//
//

import Foundation
import CoreData


extension TaskCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskCoreData> {
        return NSFetchRequest<TaskCoreData>(entityName: "TaskCoreData")
    }

    @NSManaged public var text: String?

}
