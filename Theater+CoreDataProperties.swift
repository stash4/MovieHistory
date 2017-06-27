//
//  Theater+CoreDataProperties.swift
//  MovieHistory
//
//  Created by Hironobu Makado on 2017/05/13.
//  Copyright © 2017年 stash4. All rights reserved.
//

import Foundation
import CoreData


extension Theater {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Theater> {
        return NSFetchRequest<Theater>(entityName: "Theater")
    }

    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var screens: NSSet?

}

// MARK: Generated accessors for screens
extension Theater {

    @objc(addScreensObject:)
    @NSManaged public func addToScreens(_ value: Screen)

    @objc(removeScreensObject:)
    @NSManaged public func removeFromScreens(_ value: Screen)

    @objc(addScreens:)
    @NSManaged public func addToScreens(_ values: NSSet)

    @objc(removeScreens:)
    @NSManaged public func removeFromScreens(_ values: NSSet)

}
