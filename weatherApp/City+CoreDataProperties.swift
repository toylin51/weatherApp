//
//  City+CoreDataProperties.swift
//  weatherApp
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City");
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var fav: Bool

}
