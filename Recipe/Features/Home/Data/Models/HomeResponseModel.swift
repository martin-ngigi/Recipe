//
//  HomeResponseModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation
import SwiftData

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

    convenience init(model: HomeResponseModel) {
        self.init(
            message: model.message,
            statusCode: model.statusCode,
            data: HomeDataSwiftData(model: model.data)
        )
    }

    deinit {}
}

struct HomeResponseModel: Codable {

    enum CodingKeys: String, CodingKey {
        case message
        case statusCode = "status_code"
        case data
    }

    static var sampleData = HomeReponseDummyData.dataModel

    let message: String
    let statusCode: Int
    let data: HomeData

    init(swiftData: HomeResponseSwiftData) {
        self.message = swiftData.message
        self.statusCode = swiftData.statusCode
        self.data = HomeData(swiftData: swiftData.data)
    }

}
