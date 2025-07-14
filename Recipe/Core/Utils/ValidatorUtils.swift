//
//  ValidatorUtils.swift
//  Recipe
//
//  Created by Hummingbird on 13/07/2025.
//

import Foundation

class ValidatorUtils{
    static let shared = ValidatorUtils()
    func validateEmail(email: String) -> String {
        // Check if the email is empty
        if email.isEmpty {
            return "Email address is required."
        }
        // Regular expression for a valid email address
        let pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: email.utf16.count)
        if regex?.firstMatch(in: email, options: [], range: range) == nil {
            return "Invalid email address format."
        }
        // No error
        return ""
    }
    
    func validatePassword(password: String) -> [String] {
        var errors: [String] = []
        
        if password.count < 8 {
            errors.append("Password must be at least 8 characters long.")
        }
        if !password.contains(where: { $0.isUppercase }) {
            errors.append("Password must contain at least one uppercase letter.")
        }
        if !password.contains(where: { $0.isNumber }) {
            errors.append("Password must contain at least one digit.")
        }
        if !password.contains(where: { "!@#$%^&*".contains($0) }) {
            errors.append("Password must contain at least one special character.")
        }
        
        return errors
    }

    func validateFullName(name: String) -> String {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty {
            return "Name is required."
        }
        
        // Split the name by spaces
        let nameParts = trimmedName.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
        
        // Check if there are at least two parts (first and last name)
        if nameParts.count < 2 {
            return "Please enter both first and last name."
        }
        
        // Check each part contains only alphabetic characters (allowing hyphens and apostrophes)
        let nameRegex = "^[A-Za-z'-]+$"
        for part in nameParts {
            if !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: part) {
                return "Name can only contain letters, hyphens, and apostrophes."
            }
        }
        
        // All validations passed
        return ""
    }


}
