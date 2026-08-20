/*
* Created by Martin Wainaina on 20/08/2026
*
* Feel free to contribute.
*/

//
//  NotificationModel.swift
//  Recipe
//
//  Created by RAFIKI on 19/08/2026.
//

import Foundation

import Foundation

struct NotificationModel: Identifiable, Hashable {
    let id: UUID
    let category: NotificationCategory
    let title: String?
    let message: String?
    let date: String?
    let isRead: Bool
    let isStarred: Bool

    init(
        id: UUID = UUID(),
        category: NotificationCategory,
        title: String,
        message: String,
        date: String,
        isRead: Bool = false,
        isStarred: Bool = false
    ) {
        self.id = id
        self.category = category
        self.title = title
        self.message = message
        self.date = date
        self.isRead = isRead
        self.isStarred = isStarred
    }
}

extension NotificationModel {

    static let dummyNotifications: [NotificationModel] = [

        // MARK: - Today

        NotificationModel(
            category: .inbox,
            title: "New Recipe For You",
            message: "We found a delicious creamy garlic chicken recipe that we think you'll love.",
            date: "19 Aug 2026 10:35 AM",
            isRead: false,
            isStarred: true
        ),

        NotificationModel(
            category: .inbox,
            title: "Recipe Collection Updated",
            message: "Your saved recipes have been updated. Check out your favourites and discover something new.",
            date: "19 Aug 2026 09:20 AM",
            isRead: false
        ),

        NotificationModel(
            category: .promotions,
            title: "Weekend Cooking Ideas",
            message: "Make your weekend special with our collection of easy family-friendly recipes.",
            date: "19 Aug 2026 08:15 AM",
            isRead: true
        ),

        NotificationModel(
            category: .inbox,
            title: "Chef You Follow Posted",
            message: "Chef Maria has just published a new recipe: Spicy Coconut Chicken Curry.",
            date: "19 Aug 2026 07:42 AM",
            isRead: false,
            isStarred: true
        ),

        // MARK: - Yesterday

        NotificationModel(
            category: .inbox,
            title: "Recipe Reminder",
            message: "You saved Chocolate Chip Banana Bread a while ago. Why not try making it today?",
            date: "18 Aug 2026 04:30 PM",
            isRead: true
        ),

        NotificationModel(
            category: .promotions,
            title: "New Recipe Collection",
            message: "Explore 20 quick dinner recipes that can be prepared in under 30 minutes.",
            date: "18 Aug 2026 12:10 PM",
            isRead: true,
            isStarred: true
        ),

        NotificationModel(
            category: .inbox,
            title: "Someone Liked Your Recipe",
            message: "James liked your Homemade Beef Burger recipe.",
            date: "18 Aug 2026 10:45 AM",
            isRead: false
        ),

        // MARK: - Earlier

        NotificationModel(
            category: .inbox,
            title: "New Recipe Published",
            message: "A new Mediterranean Pasta recipe is now available. Fresh ingredients, simple preparation and lots of flavour.",
            date: "17 Aug 2026 03:25 PM",
            isRead: true
        ),

        NotificationModel(
            category: .inbox,
            title: "Your Favourite Chef",
            message: "Chef Daniel added three new breakfast recipes to his collection.",
            date: "17 Aug 2026 09:15 AM",
            isRead: true,
            isStarred: true
        ),

        NotificationModel(
            category: .promotions,
            title: "Meal Planning Made Easy",
            message: "Discover our new collection of recipes designed to help you plan delicious meals for the entire week.",
            date: "16 Aug 2026 05:40 PM",
            isRead: true
        ),

        NotificationModel(
            category: .inbox,
            title: "Recipe Recommendation",
            message: "Based on your recent favourites, you might enjoy our creamy mushroom pasta.",
            date: "16 Aug 2026 11:30 AM",
            isRead: false
        ),

        NotificationModel(
            category: .promotions,
            title: "Summer Recipes",
            message: "Cool down with our refreshing summer recipes including smoothies, salads and homemade ice cream.",
            date: "15 Aug 2026 02:20 PM",
            isRead: true
        )
    ]
}
