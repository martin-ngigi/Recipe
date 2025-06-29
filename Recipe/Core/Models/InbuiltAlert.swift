//
//  InbuiltAlert.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

struct InbuiltAlert{
    var title: String
    var message: String? = nil
    
    init(
        title: String,
        message: String? = nil
    ) {
        self.title = title
        self.message = message
    }
}
