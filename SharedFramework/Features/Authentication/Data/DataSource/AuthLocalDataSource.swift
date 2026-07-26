//
//  AuthLocalDataSource.swift
//  Recipe
//
//  Created by Hummingbird on 14/07/2025.
//

import Foundation
import SwiftData
import os

final class AuthLocalDataSource {

    @MainActor
    static let shared = AuthLocalDataSource()

    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    private init() {
        do {
            self.modelContainer = try ModelContainer(for: UserSwiftData.self)
            self.modelContext = modelContainer.mainContext
        }
        catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    func saveUser(user: UserSwiftData) {
        modelContext.insert(user)
        save()
    }

    func fetchUser() -> UserSwiftData? {
        do {
            let users = try modelContext.fetch(FetchDescriptor<UserSwiftData>())
            return users.first
        }
        catch {
            fatalError("Failed to fetch : \(error.localizedDescription)")
        }
    }

    func deleteUser(user: UserSwiftData) {
        let user = fetchUser()
        if let userToDelete = user, user?.openID == userToDelete.openID {
            os.Logger().debug("DEBUG: user \(userToDelete.email) deleted successfully")
            modelContext.delete(userToDelete)
        }
        save()
    }

    func save() {
        do {
            try modelContext.save()
        }
        catch {
            fatalError("Failed to save \(error.localizedDescription)")
        }
    }

    deinit {}
}
