//
//  MenuItem.swift
//  Little Lemon
//
//  Created by R.A. on 21/12/24.
//

import Foundation


struct MenuItem: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case price = "price"
        case image = "image"
        case category = "category"
    }
    
}


/*
 
 "id": 1,
 "title": "Greek Salad",
 "description": "The famous greek salad of crispy lettuce, peppers, olives, our Chicago.",
 "price": "10",
 "image": "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true",
 "category": "starters"
 
 */
