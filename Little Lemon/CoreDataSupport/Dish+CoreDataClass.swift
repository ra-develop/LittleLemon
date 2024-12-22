//
//  Dish+CoreDataClass.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//
//

import Foundation
import CoreData

@objc(Dish)
public class Dish: NSManagedObject {

    func formatPrice() -> String {
        let spacing = price < 10 ? " " : ""
        return "$ " + spacing + String(format: "%.2f", price)
    }
    
}
