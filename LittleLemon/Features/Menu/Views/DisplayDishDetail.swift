//
//  DisplayDishDetail.swift
//  Little Lemon
//
//  Created by R.A. on 22/12/24.
//

import SwiftUI

struct DisplayDishDetail: View {
    @State private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: dish.image!)){ phase in
                switch phase {
                case .failure:
                    Image(systemName: "photo.badge.exclamationmark")
                        .font(.largeTitle)
                case .success(let image):
                    image
                        .resizable()
                default:
                    ProgressView()
                }
            }
            .frame(width: 256, height: 256)
            .clipShape(.rect(cornerRadius: 25))
            Text(dish.title!)
            Text(dish.descript!)
            HStack {
                Text(dish.category!)
                Spacer()
                Text(dish.formatPrice()).font(Font.system(.callout, design: .monospaced))
            }.padding()
            
        }.padding()
    }
}

#Preview {

    let context = PersistenceController.shared.container.viewContext
    var oneDish:Dish = {
        let dish = Dish(context: context)
        dish.title = "Greek Salad"
        dish.price = 10
        dish.category = "starters"
        dish.descript = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        return dish
    }()
    
    DisplayDishDetail(oneDish)

}


/*
 
 {
   "id": 1,
   "title": "Greek Salad",
   "description": "The famous greek salad of crispy lettuce, peppers, olives, our Chicago.",
   "price": "10",
   "image": "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true",
   "category": "starters"
 },
 
 */
