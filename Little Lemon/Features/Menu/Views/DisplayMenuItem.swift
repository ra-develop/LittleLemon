//
// DisplayDish.swift



import SwiftUI


struct DisplayMenuItem: View {
    @ObservedObject private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {        
//        EmptyView()
        HStack(alignment: .center) {
            Text(dish.title ?? "")
            Spacer()
            Text(dish.formatPrice()).font(Font.system(.callout, design: .monospaced))
        }
        .contentShape(Rectangle()) // keep this code
    }
}

struct DisplayDish_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        DisplayMenuItem(oneDish())
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.title = "Hummus"
        dish.price = 10
        dish.category = "Extra Large"
        return dish
    }
}

