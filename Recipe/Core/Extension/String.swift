//
//  String.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

import Foundation

extension String {
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
        } catch {
            print("Decoding error: \(error)")
            return [self]
        }
    }
    
    var instructionsList: [String] {
        // Add a leading space to help splitting the first item if it starts with "1."
        let modifiedString = " " + self
        
        // Regex pattern to match number + fullstop + optional whitespace, e.g. "1. ", "2. "
        let pattern = "\\d+\\.\\s*"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: modifiedString, options: [], range: NSRange(location: 0, length: modifiedString.utf16.count))
            
            var results = [String]()
            var lastIndex = modifiedString.startIndex
            
            for match in matches {
                if let range = Range(match.range, in: modifiedString) {
                    // Extract substring from lastIndex to current match start
                    let substring = modifiedString[lastIndex..<range.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
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
        } catch {
            // If regex fails, fallback to returning the whole string as a single element
            return [self]
        }
    }
}
