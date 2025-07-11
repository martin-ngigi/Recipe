//
//  HomeResponseModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation
import SwiftData

struct HomeResponseModel: Codable{
    let message: String
    let statusCode: Int
    let data: HomeData
    
    enum CodingKeys: String, CodingKey {
        case message
        case statusCode = "status_code"
        case data
    }
}

extension HomeResponseModel {
    init(swiftData: HomeResponseSwiftData) {
        self.message = swiftData.message
        self.statusCode = swiftData.statusCode
        self.data = HomeData(swiftData: swiftData.data)
    }
}

@Model
class HomeResponseSwiftData {
    var message: String
    var statusCode: Int
    var data: HomeDataSwiftData

    init(message: String, statusCode: Int, data: HomeDataSwiftData) {
        self.message = message
        self.statusCode = statusCode
        self.data = data
    }
}

extension HomeResponseSwiftData {
    convenience init(model: HomeResponseModel) {
        self.init(
            message: model.message,
            statusCode: model.statusCode,
            data: HomeDataSwiftData(model: model.data)
        )
    }
}

extension HomeResponseModel {
    static var sampleData =  HomeReponseDummyData.dataModel
}
