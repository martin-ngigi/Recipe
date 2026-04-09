//
//  HttpMethod.swift
//  Recipe
//
//  Created by RAFIKI on 09/04/2026.
//

import Foundation

enum HttpMethod: String {
    case post
    case get
    case put
    case delete
    case patch
    
    var getMethod: String {
        switch self {
        case .post:
            return "POST"
        case .get:
            return "GET"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        case .patch:
            return "PATCH"
        }
    }
    
}
