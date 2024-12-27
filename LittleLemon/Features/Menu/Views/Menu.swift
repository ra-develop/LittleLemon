//
//  Menu.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//

import CoreData
import SwiftUI

struct Category: Hashable {
    let name: String
    var status: Bool
    mutating func toggleStatus() {
        self.status.toggle()
    }
}

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    @ObservedObject var dishesModel = DishesModel()
    @State var selectedCategory = ""
    @State var selectedCategories: [Category] = []

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedCaseInsensitiveCompare))
        ],
        predicate: NSPredicate(value: true),
        animation: .default
    ) private var dishes: FetchedResults<Dish>

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(selectedCategories, id: \.self) { category in

                            Button(action: {
                                selectCategory(category)
                            }) {
                                Text(category.name)
                            }
                            .buttonStyle(
                                CategoryButton(
                                    isActive: category.name == selectedCategory)
                            )

                        }
                    }
                }.padding(.horizontal, 20)

                List {
                    ForEach(
                        dishes.filter({ compoundPredicate.evaluate(with: $0) }),
                        id: \.self
                    ) { dish in

                        NavigationLink(
                            destination: {
                                DisplayDishDetail(dish)
                            },
                            label: {
                                DisplayMenuItem(dish)
                            }
                        )

                    }
                }
                .searchable(text: $searchText, prompt: "search...")
                .navigationTitle("Order for delivery!")
                .navigationBarTitleDisplayMode(.large)
            }

        }
        .task {
            await dishesModel.reload(viewContext)

            selectedCategories = Array(
                Set(
                    dishes.map {
                        Category(name: $0.category ?? "", status: false)
                    }))
        }
//        .navigationTitle("List")
//        .navigationBarTitleDisplayMode(.large)
    }

    var compoundPredicate: NSPredicate {
        var predicates: [NSPredicate] = []

        if selectedCategory.isEmpty {
            if searchText.isEmpty {
                predicates.append(NSPredicate(value: true))
            } else {
                predicates.append(
                    NSPredicate(format: "title CONTAINS[cd] %@", searchText))
            }
        } else {
            if searchText.isEmpty {
                predicates.append(
                    NSPredicate(
                        format: "category CONTAINS[cd] %@", selectedCategory))
            } else {
                predicates.append(
                    NSPredicate(format: "title CONTAINS[cd] %@", searchText))
                predicates.append(
                    NSPredicate(
                        format: "category CONTAINS[cd] %@", selectedCategory))
            }
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }

    func selectCategory(_ category: Category) {
        if category.name == selectedCategory {
            selectedCategory = ""
        } else {
            selectedCategory = category.name
        }

    }

}

#Preview {
    let persistenceController = PersistenceController.shared

    Menu()
        .environment(
            \.managedObjectContext, persistenceController.container.viewContext)
}

/*

 Step 8: Displaying the list of menu items from the database
 Update the List element of the Menu view to display the Dish items that were saved to the database.

 Remove the List element from the Menu view for now, and in its place, add the following call to it: FetchedObjects: FetchedObjects() { (dishes: [Dish]) in }. This will fetch all the Dishes from the core data and make them available to use in the closure.

 Inside the closure add a List element.

 Inside the list element, use the ForEach element and pass the dishes argument of the closure to its constructor.

 Add a trailing closure right after the ForEach element initialization and make closure get a single dish argument.

 Inside the ForEach trailing closure body, add a new HStack element.

 Inside the stack element, add a  Text element and initialize it with a String that would be a combination of the title and the price of the dish argument of the closure to display them.

 Also, inside the stack, after the text element add an AsyncImage element and initialise it by using the constructor that takes a url argument. Create a new URL object using the image property of the dish variable, and set it to the constructor.

 Images might be too big, so you will have to style them to resize them. You can read about the AsyncImage styling
 here
 .

 */
