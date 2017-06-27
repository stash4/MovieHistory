//
//  Screen+CoreDataProperties.swift
//  MovieHistory
//
//  Created by Hironobu Makado on 2017/05/13.
//  Copyright © 2017年 stash4. All rights reserved.
//

import Foundation
import CoreData


extension Screen {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Screen> {
        return NSFetchRequest<Screen>(entityName: "Screen")
    }

    @NSManaged public var note: String?
    @NSManaged public var number: String?
    @NSManaged public var theater: Theater?
    @NSManaged public var histories: NSSet?

}

// MARK: Generated accessors for histories
extension Screen {

    @objc(addHistoriesObject:)
    @NSManaged public func addToHistories(_ value: History)

    @objc(removeHistoriesObject:)
    @NSManaged public func removeFromHistories(_ value: History)

    @objc(addHistories:)
    @NSManaged public func addToHistories(_ values: NSSet)

    @objc(removeHistories:)
    @NSManaged public func removeFromHistories(_ values: NSSet)

}
