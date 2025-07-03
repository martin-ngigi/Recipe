//
//  RecipeModel.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation

struct RecipeModel: Codable, Hashable{
    let recipeId: String
    let name: String
    let description: String
    let ingredients: [IngredientModel]
    let image: String
    let chefId: String
    let instructions: String
    let chef: ChefModel? = nil
    var inststuctionsList: [String]{
        return instructions.instructionsList
    }
    
    enum CodingKeys: String, CodingKey {
        case recipeId = "recipe_id"
        case name
        case description
        case ingredients
        case image
        case chefId = "chef_id"
        case instructions
        case chef
    }
}

extension RecipeModel{
    
    static var sampleRecipeModel: RecipeModel = RecipeModel(
        recipeId: "20d691d4-71b3-4ba4-91ac-df65947afb2a",
        name: "Nyama Choma",
        description: "Nyama Choma is a delicious Kenyan goat meat delicacy you can enjoy any time of the day. It is nutritious, versatile, and oh-so finger-licking good!",
        ingredients: [
            IngredientModel(
                ingredientID: "071a41bb-35a5-4018-8eb2-00e42ff361cb",
                name: "Goat Meat (Nyama Choma Classic)",
                image: "https://halalmeatnj.com/cdn/shop/files/00690085390334.jpg?v=1740430667",
                quantity: "1 Kg",
                recipeID: "0f6eeb79-43eb-4038-8c81-f2224b850d65",
                createdAt: "2025-07-03T07:00:25.000000Z",
                updatedAt: "2025-07-03T07:00:25.000000Z"
            ),
            IngredientModel(
                ingredientID: "334774a5-7724-4c13-b865-5c842224cd90",
                name: "Curry Powder",
                image: "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                quantity: "1 teaspoon",
                recipeID: "0f6eeb79-43eb-4038-8c81-f2224b850d65",
                createdAt: "2025-07-03T07:00:25.000000Z",
                updatedAt: "2025-07-03T07:00:25.000000Z"
            ),
            IngredientModel(
                ingredientID: "33b854f2-46a0-4b98-9b4d-63d1fb044b4d",
                name: "Rosemary (fresh or dried)",
                image: "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                quantity: "1 teaspoon, minced",
                recipeID: "0f6eeb79-43eb-4038-8c81-f2224b850d65",
                createdAt: "2025-07-03T07:00:25.000000Z",
                updatedAt: "2025-07-03T07:00:25.000000Z"
            ),
            IngredientModel(
                ingredientID: "3d4c1014-91af-4610-bafd-d7560408141b",
                name: "Lemon Juice (freshly squeezed)",
                image: "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                quantity: "1/4 cup",
                recipeID: "0f6eeb79-43eb-4038-8c81-f2224b850d65",
                createdAt: "2025-07-03T07:00:25.000000Z",
                updatedAt: "2025-07-03T07:00:25.000000Z"
            ),
            IngredientModel(
                ingredientID: "071a41bb-35a5-4018-8eb2-00e42ff361cb",
                name: "Goat Meat (Nyama Choma Classic)",
                image: "https://halalmeatnj.com/cdn/shop/files/00690085390334.jpg?v=1740430667",
                quantity: "1 Kg",
                recipeID: "0f6eeb79-43eb-4038-8c81-f2224b850d65",
                createdAt: "2025-07-03T07:00:25.000000Z",
                updatedAt: "2025-07-03T07:00:25.000000Z"
            ),
            IngredientModel(
                ingredientID: "334774a5-7724-4c13-b865-5c842224cd90",
                name: "Curry Powder",
                image: "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                quantity: "1 teaspoon",
                recipeID: "0f6eeb79-43eb-4038-8c81-f2224b850d65",
                createdAt: "2025-07-03T07:00:25.000000Z",
                updatedAt: "2025-07-03T07:00:25.000000Z"
            ),
            IngredientModel(
                ingredientID: "33b854f2-46a0-4b98-9b4d-63d1fb044b4d",
                name: "Rosemary (fresh or dried)",
                image: "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                quantity: "1 teaspoon, minced",
                recipeID: "0f6eeb79-43eb-4038-8c81-f2224b850d65",
                createdAt: "2025-07-03T07:00:25.000000Z",
                updatedAt: "2025-07-03T07:00:25.000000Z"
            ),
            IngredientModel(
                ingredientID: "3d4c1014-91af-4610-bafd-d7560408141b",
                name: "Lemon Juice (freshly squeezed)",
                image: "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                quantity: "1/4 cup",
                recipeID: "0f6eeb79-43eb-4038-8c81-f2224b850d65",
                createdAt: "2025-07-03T07:00:25.000000Z",
                updatedAt: "2025-07-03T07:00:25.000000Z"
            ),
        ],
        image: "https://cdn.foodandmeal.com/wp-content/uploads/2023/10/3.1-1-3.jpg?strip=all&lossy=1&ssl=1\"",
        chefId: "8ab3e4a3-e2c5-45d9-82af-1dc521ac6754",
        instructions:  "1. Wash and drain the goat meat, then cut them into smaller bite sizes. 2.Pour your oil and spices into a mixing bowl and mix them. 3. Blend the onions and garlic coarsely in a food processor, or finely chop them if you prefer. 4. Put the chunks of meat into the mixing bowl, add the spices, the blended garlic, and onion, and properly mix everything. 5. Marinate it in the fridge for 2 hours or longer. I prefer to let it marinate overnight for even more flavor. 6. Bring it out of the refrigerator and let it come to room temperature. 7. Turn the grill to medium-low heat and arrange the meat on the grill. 8. Add 2 tablespoon of salt to 2 cups of water. Grill the meat for 50 minutes, turning every 10 minutes and basting with the salt water."
    )
}
