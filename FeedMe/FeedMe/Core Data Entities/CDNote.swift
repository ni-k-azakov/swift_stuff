//
//  CDNote.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 26.05.2022.
//

import CoreData

@objc(Note)
class CDNote: NSManagedObject {
    @NSManaged var id: NSNumber!
    @NSManaged var rating: NSNumber?
    @NSManaged var adress: String!
    @NSManaged var brand: String!
    @NSManaged var date: Date!
}
