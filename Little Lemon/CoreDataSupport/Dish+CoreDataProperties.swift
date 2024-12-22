//
//  Dish+CoreDataProperties.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var category: String?
    @NSManaged public var descript: String?
    @NSManaged public var image: String?
    @NSManaged public var price: Float
    @NSManaged public var title: String?

}

extension Dish : Identifiable {

}
