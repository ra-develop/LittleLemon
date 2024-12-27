import Foundation

struct MenuList: Codable {
    // add code here
    var menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
    
}
 /*
  
  {
    "menu": [
      {
        "id": 1,
        "title": "Greek Salad",
        "description": "The famous greek salad of crispy lettuce, peppers, olives, our Chicago.",
        "price": "10",
        "image": "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true",
        "category": "starters"
      },
      ]
  }
  
  */
