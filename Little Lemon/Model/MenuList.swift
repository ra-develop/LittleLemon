import Foundation

struct MenuList: Codable {
    // add code here
    var menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
    
}


struct MenuItem: Codable, Identifiable {
    let id = UUID()
    
    // add code here
    let title: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case price = "price"
    }
    
}
