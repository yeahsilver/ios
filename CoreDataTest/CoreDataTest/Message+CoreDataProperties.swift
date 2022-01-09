//
//  Message+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by 허예은 on 2022/01/09.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var id: String?
    @NSManaged public var number: String?
    @NSManaged public var contact: Contact?

}

extension Message : Identifiable {

}
