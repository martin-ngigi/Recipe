/*
* Created by Martin Wainaina on 13/09/2026
*
* Feel free to contribute.
*/

//
//  StringOrDouble.swift
//  Recipe
//
//  Created by RAFIKI on 08/09/2026.
//

import Foundation

@propertyWrapper
struct StringOrDouble: Codable, Hashable {
    var wrappedValue: String?

    init(wrappedValue: String?) {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            wrappedValue = nil
        }
        else if let string = try? container.decode(String.self) {
            wrappedValue = string
        }
        else if let double = try? container.decode(Double.self) {
            wrappedValue = String(double)
        }
        else if let int = try? container.decode(Int.self) {
            wrappedValue = String(int)
        }
        else if let float = try? container.decode(Float.self) {
            wrappedValue = String(float)
        }
        else {
            wrappedValue = nil
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
