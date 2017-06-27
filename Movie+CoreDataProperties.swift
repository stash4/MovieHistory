//
//  Movie+CoreDataProperties.swift
//  MovieHistory
//
//  Created by Hironobu Makado on 2017/06/02.
//  Copyright © 2017年 stash4. All rights reserved.
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var note: String?
    @NSManaged public var title: String?
    @NSManaged public var year: Int16
    @NSManaged public var histories: NSSet?
    @NSManaged public var tags: NSOrderedSet?
    @NSManaged public var images: NSSet?

}

// MARK: Generated accessors for histories
extension Movie {

    @objc(addHistoriesObject:)
    @NSManaged public func addToHistories(_ value: History)

    @objc(removeHistoriesObject:)
    @NSManaged public func removeFromHistories(_ value: History)

    @objc(addHistories:)
    @NSManaged public func addToHistories(_ values: NSSet)

    @objc(removeHistories:)
    @NSManaged public func removeFromHistories(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension Movie {

    @objc(insertObject:inTagsAtIndex:)
    @NSManaged public func insertIntoTags(_ value: Tag, at idx: Int)

    @objc(removeObjectFromTagsAtIndex:)
    @NSManaged public func removeFromTags(at idx: Int)

    @objc(insertTags:atIndexes:)
    @NSManaged public func insertIntoTags(_ values: [Tag], at indexes: NSIndexSet)

    @objc(removeTagsAtIndexes:)
    @NSManaged public func removeFromTags(at indexes: NSIndexSet)

    @objc(replaceObjectInTagsAtIndex:withObject:)
    @NSManaged public func replaceTags(at idx: Int, with value: Tag)

    @objc(replaceTagsAtIndexes:withTags:)
    @NSManaged public func replaceTags(at indexes: NSIndexSet, with values: [Tag])

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSOrderedSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSOrderedSet)

}

// MARK: Generated accessors for images
extension Movie {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: Image)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: Image)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}
