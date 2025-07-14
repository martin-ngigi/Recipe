//
//  LocalUserDataSource.swift
//  Recipe
//
//  Created by Hummingbird on 14/07/2025.
//

import Foundation
import SwiftData


final class LocalUserDataSource{
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = LocalUserDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: UserSwiftData.self)
        self.modelContext = modelContainer.mainContext
    }
    
    func saveUser(user: UserSwiftData) {
        modelContext.insert(user)
        save()
    }

    func fetchUser() -> UserSwiftData? {
        do {
           let users = try modelContext.fetch(FetchDescriptor<UserSwiftData>())
            return users.first
        } catch {
            fatalError("Failed to fetch : \(error.localizedDescription)")
        }
    }

    func deleteUser(user: UserSwiftData) {
        let user =  fetchUser()
        if let userToDelete = user, user?.openID == userToDelete.openID {
            modelContext.delete(userToDelete)
        }
        save()
    }
    
    func save() {
        do {
            try modelContext.save()
        } catch {
            fatalError("Failed to save \(error.localizedDescription)")
        }
    }
}
