import Foundation
import CoreData


extension Dish {

    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        menuItems.forEach { item in
            if let isItemExist = self.exists(title: item.title, context) {
                if !isItemExist {
                    let dish = Dish(context: context)
                    dish.title = item.title
                    dish.price = (item.price as NSString).floatValue
                    dish.category = item.category
                    dish.descript = item.description
                    dish.image = item.image
                }
            }
        }
        self.save(context)
    }
    
}
