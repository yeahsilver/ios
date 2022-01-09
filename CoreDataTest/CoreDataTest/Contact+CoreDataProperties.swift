//
//  Contact+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by 허예은 on 2022/01/09.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var number: String?

}

extension Contact : Identifiable {

}
