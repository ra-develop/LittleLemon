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
        GeometryReader {proxy in
            VStack(spacing: 20) {
                HStack {
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
                    .cornerRadius(25)
                    //                .clipShape(.rect(cornerRadius: 25))
                }
                .frame(width: proxy.size.width , height: 300)
                .background(.primaryColors1, ignoresSafeAreaEdges: .horizontal)
                VStack(alignment: .leading ) {
                    Text(dish.title!).typographyStyle(.headline)
                    Text(dish.descript!).typographyStyle(.subheadline)
                    HStack {
                        Text(dish.category!).typographyStyle(.title2)
                        Spacer()
                        Text(dish.formatPrice())
                            .typographyStyle(.subheadline)
                    }
                }.padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("Logo")
                }
            }
        }
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
