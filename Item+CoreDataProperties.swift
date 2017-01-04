//
//  Item+CoreDataProperties.swift
//  To Do List
//
//  Created by Jeff Li on 1/4/17.
//  Copyright © 2017 Jeff Li. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var title: String?

}
