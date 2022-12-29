//
//  Menu.swift
//  FoodOrderApp
//
//  Created by Deniz Gülbahar on 18.07.2022.
//

import Foundation
class Menu:Codable {
    var category:String?
    var name:String?
    var description:String?
    var price:Int?
    var image:String?
    init() {
    }
    init(category:String, name:String, description:String, price:Int, image:String?) {
        self.category = category
        self.name = name
        self.description = description
        self.price = price
        self.image = image
        
    }
    
    
}
