/*
* Created by Martin Wainaina on 20/08/2026
*
* Feel free to contribute.
*/

//
//  String.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

extension String {

    var instructionsList: [String] {
        // Add a leading space to help splitting the first item if it starts with "1."
        let modifiedString = " " + self

        // Regex pattern to match number + fullstop + optional whitespace, e.g. "1. ", "2. "
        let pattern = #"\d+\.\s*"#
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(
                in: modifiedString,
                options: [],
                range: NSRange(location: 0, length: modifiedString.utf16.count)
            )

            var results = [String]()
            var lastIndex = modifiedString.startIndex

            for match in matches {
                if let range = Range(match.range, in: modifiedString) {
                    // Extract substring from lastIndex to current match start
                    let substring = modifiedString[lastIndex..<range.lowerBound].trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )
                    if !substring.isEmpty {
                        results.append(substring)
                    }
                    lastIndex = range.upperBound
                }
            }

            // Add the last part after the last match
            let lastSubstring = modifiedString[lastIndex...].trimmingCharacters(in: .whitespacesAndNewlines)
            if !lastSubstring.isEmpty {
                results.append(lastSubstring)
            }

            return results
        }
        catch {
            // If regex fails, fallback to returning the whole string as a single element
            return [self]
        }
    }

    /// Converts a JSON string representing an array of strings into [String].
    /// Returns nil if decoding fails.
    func toStringList() -> [String] {
        // Convert the string to Data
        guard let data = self.data(using: .utf8) else {
            return [self]
        }

        // Decode the JSON data into [String]
        do {
            let list = try JSONDecoder().decode([String].self, from: data)
            return list
        }
        catch {
            return [self]
        }
    }

    func to2Decimals() -> String {
        return String(format: "%.2f", Double(self) ?? 0.0)
    }

    func decodeJSON<T: Decodable>(to type: T.Type) -> T? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func removeEmojis() -> String {
        return String(self.filter { !$0.isEmoji })
    }

    
    func toDate() -> Date? {
        guard !isEmpty else {
            return nil
        }

        let formats = [
            "dd MMM yyyy hh:mm a",
            "dd MMM hh:mm a",
            "dd MMM yyyy"
        ]

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current

        for format in formats {
            formatter.dateFormat = format

            guard let date = formatter.date(from: self) else {
                continue
            }

            // Input doesn't contain a year.
            if format == "dd MMM hh:mm a" {
                var components = Calendar.current.dateComponents(
                    [.month, .day, .hour, .minute],
                    from: date
                )

                components.year = Calendar.current.component(
                    .year,
                    from: Date()
                )

                return Calendar.current.date(from: components)
            }

            return date
        }

        return nil
    }

    func formatted(as format: String) -> String? {
        guard let date = toDate() else {
            return nil
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = format

        return formatter.string(from: date)
    }

    func extractTime() -> String? {
        formatted(as: "hh:mm a")
    }

    func formattedNotificationDate() -> String? {
        formatted(as: "dd MMM yyyy")
    }
}
