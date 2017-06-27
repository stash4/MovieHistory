//
//  Tag+CoreDataProperties.swift
//  MovieHistory
//
//  Created by Hironobu Makado on 2017/05/13.
//  Copyright © 2017年 stash4. All rights reserved.
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var tag: String?
    @NSManaged public var historys: NSSet?

}

// MARK: Generated accessors for historys
extension Tag {

    @objc(addHistorysObject:)
    @NSManaged public func addToHistorys(_ value: History)

    @objc(removeHistorysObject:)
    @NSManaged public func removeFromHistorys(_ value: History)

    @objc(addHistorys:)
    @NSManaged public func addToHistorys(_ values: NSSet)

    @objc(removeHistorys:)
    @NSManaged public func removeFromHistorys(_ values: NSSet)

}
