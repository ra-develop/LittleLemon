//
//  Menu.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    

    var body: some View {
        VStack {
            Text("Little Lemon App")
            Text("Chicago")
            Text("Short description of the whole application")
            FetchedObjects() { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack(alignment: .center) {
                            Text(dish.title ?? "")
                            Spacer()
                            Text(dish.formatPrice()).font(Font.system(.callout, design: .monospaced))
                        }
                    }
                }
                
            }
        }
        .onAppear() {
            getMenuData()
        }
    }
    
    func getMenuData(){
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        
        let request = URLRequest(url: url)
        let urlSession = URLSession.shared
        
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    PersistenceController.shared.clear()
                    try? viewContext.save()
                    let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
                    let menuItems = fullMenu.menu
                    menuItems.forEach {menuItem in

                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.price = (menuItem.price as NSString).floatValue
                        dish.category = menuItem.category
                        dish.descript = menuItem.description
                        dish.image = menuItem.image
                        
                    }
                    try? viewContext.save()

                } catch { }
            }
        }

        dataTask.resume()

    }
}

#Preview {
    Menu()
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
