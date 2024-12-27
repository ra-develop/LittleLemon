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

