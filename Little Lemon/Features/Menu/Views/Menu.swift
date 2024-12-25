//
//  Menu.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    @ObservedObject var dishesModel = DishesModel()

    var body: some View {
        VStack {
            Text("Place for selecting the categories")
            NavigationView {
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()
                ) { (dishes: [Dish]) in
                    List {
                        ForEach(dishes, id: \.self) { dish in
                            
                            NavigationLink(
                                destination: {
                                    DisplayDishDetail(dish)
                                },
                                label: {
                                    DisplayMenuItem(dish)
                                })
                        }
                    }
                    .searchable(text: $searchText, prompt: "search...")
                    
                }
            }
            Spacer()
        }
        .task {
            await dishesModel.reload(viewContext)
        }
    }

    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
            // NSPredicate(format: "TRUEPREDICATE")
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }

    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedCaseInsensitiveCompare))
        ]
    }

}

#Preview {
    let persistenceController = PersistenceController.shared

    Menu()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
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
