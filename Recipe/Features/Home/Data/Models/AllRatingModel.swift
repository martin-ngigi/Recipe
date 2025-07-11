//
//  AllRatingModel.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation
import SwiftData

struct AllRatingModel: Codable, Hashable {
    let rateID, rateeID, raterID: String
    let rating: Double
    let comment: String
    let rater: UserModel

    enum CodingKeys: String, CodingKey {
        case rateID = "rate_id"
        case rateeID = "ratee_id"
        case raterID = "rater_id"
        case rating, comment, rater
    }
}

extension AllRatingModel {
    init(swiftData: AllRatingSwiftData) {
        self.rateID = swiftData.rateID
        self.rateeID = swiftData.rateeID
        self.raterID = swiftData.raterID
        self.rating = swiftData.rating
        self.comment = swiftData.comment
        self.rater = UserModel(swiftData: swiftData.rater)  // Map nested UserSwiftData
    }
}

@Model
class AllRatingSwiftData {
    var rateID: String
    var rateeID: String
    var raterID: String
    var rating: Double
    var comment: String
    var rater: UserSwiftData  // Nested SwiftData model

    init(rateID: String, rateeID: String, raterID: String, rating: Double, comment: String, rater: UserSwiftData) {
        self.rateID = rateID
        self.rateeID = rateeID
        self.raterID = raterID
        self.rating = rating
        self.comment = comment
        self.rater = rater
    }
}

extension AllRatingSwiftData {
    convenience init(model: AllRatingModel) {
        self.init(
            rateID: model.rateID,
            rateeID: model.rateeID,
            raterID: model.raterID,
            rating: model.rating,
            comment: model.comment,
            rater: UserSwiftData(model: model.rater)  // Map nested UserModel
        )
    }
}
