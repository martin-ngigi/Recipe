//
//  HomeReponseDummyData.swift
//  Recipe
//
//  Created by Hummingbird on 08/07/2025.
//

import Foundation
class HomeReponseDummyData{
    static var DATA: String  = """
    {
        "message": "Home data fetched successfully.",
        "status_code": 200,
        "data": {
            "just_for_you": [
                {
                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                    "name": "Nyama Choma",
                    "description": "Nyama Choma is a delicious Kenyan goat meat delicacy you can enjoy any time of the day. It is nutritious, versatile, and oh-so finger-licking good!",
                    "image": "https://cdn.foodandmeal.com/wp-content/uploads/2023/10/3.1-1-3.jpg?strip=all&lossy=1&ssl=1",
                    "open_id": "chefjkhgefoewiwer",
                    "instructions": "1. Wash and drain the goat meat, then cut them into smaller bite sizes. 2.Pour your oil and spices into a mixing bowl and mix them. 3. Blend the onions and garlic coarsely in a food processor, or finely chop them if you prefer. 4. Put the chunks of meat into the mixing bowl, add the spices, the blended garlic, and onion, and properly mix everything. 5. Marinate it in the fridge for 2 hours or longer. I prefer to let it marinate overnight for even more flavor. 6. Bring it out of the refrigerator and let it come to room temperature. 7. Turn the grill to medium-low heat and arrange the meat on the grill. 8. Add 2 tablespoon of salt to 2 cups of water. Grill the meat for 50 minutes, turning every 10 minutes and basting with the salt water.",
                    "created_at": "2025-07-05T16:13:38.000000Z",
                    "updated_at": "2025-07-05T16:13:38.000000Z",
                    "chef": {
                        "user_id": "a10a3188-4ead-4551-89e9-063edef6e838",
                        "name": "Chef Jon",
                        "email": "chef.john@gmail.com",
                        "open_id": "chefjkhgefoewiwer",
                        "avatar": "https://img.freepik.com/free-photo/chef-cooking-kitchen-while-wearing-professional-attire_23-2151208266.jpg?semt=ais_hybrid&w=740",
                        "role": "Chef",
                        "gender": null,
                        "date_of_birth": null,
                        "phone": null,
                        "phone_complete": null,
                        "country_code": null,
                        "token": "mjOFUkM4DvBgkNcESOvzUimLXLunVIyTUENwLjD1D0CPGC0yEr1ayHbiYEceCMn2L7Y2C5itWxxLp1o9hODJ85jQcNJ031FX211ul",
                        "access_token": "Tmnym86I1YzDoicOaX9PfvRmyQ0cA4VjbyAAnqLm3xBU67ktgOBTGpXyANDXhFOojk49MM23N4OUpy4u6jemDconK66YPiMGEuJ3C",
                        "created_at": "2025-07-05T13:52:30.000000Z",
                        "updated_at": "2025-07-05T13:52:30.000000Z",
                        "rate": {
                            "rate_id": "e88cd4c8-f244-46d4-bca5-8c495b3ad55d",
                            "open_id": "chefjkhgefoewiwer",
                            "rating": 4.5,
                            "total_ratings": 1,
                            "created_at": "2025-07-05T16:15:33.000000Z",
                            "updated_at": "2025-07-05T16:15:33.000000Z"
                        }
                    },
                    "ingredients_list": [
                        {
                            "ingredient_id": "1459dd25-65b9-42c2-bf29-54d2bc98f17b",
                            "name": "Lemon Juice (freshly squeezed)",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1/4 cup",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "24c6854a-c0ad-4e73-88d5-aaa8a24e4652",
                            "name": "Vegetable Oil",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1/4 cup",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "26967d04-64b2-435b-8f66-52af405dece7",
                            "name": "Cayenne Pepper (optional)",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1/4 teaspoon",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "577ad16b-d755-47a2-a502-e96b66e5e0e7",
                            "name": "Ginger",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1 tablespoon, grated",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "a071a657-dd1e-408b-8838-08d97e8d57e3",
                            "name": "Garlic",
                            "image": "https://images.unsplash.com/photo-1502741338009-cac2772e18bc",
                            "quantity": "4 cloves, minced",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "b400169b-9b58-4473-92a9-c3a47a4a421e",
                            "name": "Curry Powder",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 teaspoon",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "bcf9684f-395d-4c2c-96cc-fcb60143b7a6",
                            "name": "Goat Meat (Nyama Choma Classic)",
                            "image": "https://halalmeatnj.com/cdn/shop/files/00690085390334.jpg?v=1740430667",
                            "quantity": "1 Kg",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "bcfcc87d-3e70-4ab4-90ed-6f44271f143d",
                            "name": "Rosemary (fresh or dried)",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1 teaspoon, minced",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "cf9a851e-832c-4b56-b914-b4d1e784211e",
                            "name": "Bouillon Powder or Soy Sauce",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 teaspoon bouillon powder or 1 tablespoon soy sauce",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "e6b85863-10f1-4be5-9aa7-f50a3186ab01",
                            "name": "Paprika",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 tablespoon",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "e9506089-d5d4-4acd-86fc-809536ce2cbf",
                            "name": "Salt",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "to taste",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "fe201314-ed73-4b81-87f5-c4a80af20f84",
                            "name": "Black Pepper",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "to taste",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        }
                    ]
                },
                {
                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                    "name": "Nyama Choma",
                    "description": "Nyama Choma is a delicious Kenyan goat meat delicacy you can enjoy any time of the day. It is nutritious, versatile, and oh-so finger-licking good!",
                    "image": "https://cdn.foodandmeal.com/wp-content/uploads/2023/10/3.1-1-3.jpg?strip=all&lossy=1&ssl=1",
                    "open_id": "chefjkhgefoewiwer",
                    "instructions": "1. Wash and drain the goat meat, then cut them into smaller bite sizes. 2.Pour your oil and spices into a mixing bowl and mix them. 3. Blend the onions and garlic coarsely in a food processor, or finely chop them if you prefer. 4. Put the chunks of meat into the mixing bowl, add the spices, the blended garlic, and onion, and properly mix everything. 5. Marinate it in the fridge for 2 hours or longer. I prefer to let it marinate overnight for even more flavor. 6. Bring it out of the refrigerator and let it come to room temperature. 7. Turn the grill to medium-low heat and arrange the meat on the grill. 8. Add 2 tablespoon of salt to 2 cups of water. Grill the meat for 50 minutes, turning every 10 minutes and basting with the salt water.",
                    "created_at": "2025-07-08T05:31:23.000000Z",
                    "updated_at": "2025-07-08T05:31:23.000000Z",
                    "chef": {
                        "user_id": "a10a3188-4ead-4551-89e9-063edef6e838",
                        "name": "Chef Jon",
                        "email": "chef.john@gmail.com",
                        "open_id": "chefjkhgefoewiwer",
                        "avatar": "https://img.freepik.com/free-photo/chef-cooking-kitchen-while-wearing-professional-attire_23-2151208266.jpg?semt=ais_hybrid&w=740",
                        "role": "Chef",
                        "gender": null,
                        "date_of_birth": null,
                        "phone": null,
                        "phone_complete": null,
                        "country_code": null,
                        "token": "mjOFUkM4DvBgkNcESOvzUimLXLunVIyTUENwLjD1D0CPGC0yEr1ayHbiYEceCMn2L7Y2C5itWxxLp1o9hODJ85jQcNJ031FX211ul",
                        "access_token": "Tmnym86I1YzDoicOaX9PfvRmyQ0cA4VjbyAAnqLm3xBU67ktgOBTGpXyANDXhFOojk49MM23N4OUpy4u6jemDconK66YPiMGEuJ3C",
                        "created_at": "2025-07-05T13:52:30.000000Z",
                        "updated_at": "2025-07-05T13:52:30.000000Z",
                        "rate": {
                            "rate_id": "e88cd4c8-f244-46d4-bca5-8c495b3ad55d",
                            "open_id": "chefjkhgefoewiwer",
                            "rating": 4.5,
                            "total_ratings": 1,
                            "created_at": "2025-07-05T16:15:33.000000Z",
                            "updated_at": "2025-07-05T16:15:33.000000Z"
                        }
                    },
                    "ingredients_list": [
                        {
                            "ingredient_id": "11207e60-b312-49c0-81b8-c7433db3b821",
                            "name": "Bouillon Powder or Soy Sauce",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 teaspoon bouillon powder or 1 tablespoon soy sauce",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "1b86cc2c-ce34-463f-890c-c039fa2aaf4c",
                            "name": "Vegetable Oil",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1/4 cup",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "473632f0-0e36-4570-ad73-352793d1e64e",
                            "name": "Rosemary (fresh or dried)",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1 teaspoon, minced",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "584c9dfb-95af-49d1-b4d4-fd90d3231789",
                            "name": "Goat Meat (Nyama Choma Classic)",
                            "image": "https://halalmeatnj.com/cdn/shop/files/00690085390334.jpg?v=1740430667",
                            "quantity": "1 Kg",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "69fe5a05-32a0-48bb-8cc8-4ef4188dbed4",
                            "name": "Curry Powder",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 teaspoon",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "77ba5f7b-e116-4b23-ba6f-d088bc19c7d8",
                            "name": "Paprika",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 tablespoon",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "99736d35-964f-4ba9-ae08-aa6712830a51",
                            "name": "Ginger",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1 tablespoon, grated",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "b709c97f-78ca-4790-98fe-3231f5d2c046",
                            "name": "Black Pepper",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "to taste",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "c8ef9d15-8b8b-4412-ac95-bbb22a5fa1e3",
                            "name": "Salt",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "to taste",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "cf261ef5-068b-45dc-a7a9-9b25957afa96",
                            "name": "Lemon Juice (freshly squeezed)",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1/4 cup",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "de7d390d-7a60-4a88-ac05-b49e2ba9cecd",
                            "name": "Garlic",
                            "image": "https://images.unsplash.com/photo-1502741338009-cac2772e18bc",
                            "quantity": "4 cloves, minced",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "e57d0944-aca6-4b72-9701-0b01c0fc6980",
                            "name": "Cayenne Pepper (optional)",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1/4 teaspoon",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        }
                    ]
                }
            ],
            "trending_recipes": [
                {
                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                    "name": "Nyama Choma",
                    "description": "Nyama Choma is a delicious Kenyan goat meat delicacy you can enjoy any time of the day. It is nutritious, versatile, and oh-so finger-licking good!",
                    "image": "https://cdn.foodandmeal.com/wp-content/uploads/2023/10/3.1-1-3.jpg?strip=all&lossy=1&ssl=1",
                    "open_id": "chefjkhgefoewiwer",
                    "instructions": "1. Wash and drain the goat meat, then cut them into smaller bite sizes. 2.Pour your oil and spices into a mixing bowl and mix them. 3. Blend the onions and garlic coarsely in a food processor, or finely chop them if you prefer. 4. Put the chunks of meat into the mixing bowl, add the spices, the blended garlic, and onion, and properly mix everything. 5. Marinate it in the fridge for 2 hours or longer. I prefer to let it marinate overnight for even more flavor. 6. Bring it out of the refrigerator and let it come to room temperature. 7. Turn the grill to medium-low heat and arrange the meat on the grill. 8. Add 2 tablespoon of salt to 2 cups of water. Grill the meat for 50 minutes, turning every 10 minutes and basting with the salt water.",
                    "created_at": "2025-07-05T16:13:38.000000Z",
                    "updated_at": "2025-07-05T16:13:38.000000Z",
                    "chef": {
                        "user_id": "a10a3188-4ead-4551-89e9-063edef6e838",
                        "name": "Chef Jon",
                        "email": "chef.john@gmail.com",
                        "open_id": "chefjkhgefoewiwer",
                        "avatar": "https://img.freepik.com/free-photo/chef-cooking-kitchen-while-wearing-professional-attire_23-2151208266.jpg?semt=ais_hybrid&w=740",
                        "role": "Chef",
                        "gender": null,
                        "date_of_birth": null,
                        "phone": null,
                        "phone_complete": null,
                        "country_code": null,
                        "token": "mjOFUkM4DvBgkNcESOvzUimLXLunVIyTUENwLjD1D0CPGC0yEr1ayHbiYEceCMn2L7Y2C5itWxxLp1o9hODJ85jQcNJ031FX211ul",
                        "access_token": "Tmnym86I1YzDoicOaX9PfvRmyQ0cA4VjbyAAnqLm3xBU67ktgOBTGpXyANDXhFOojk49MM23N4OUpy4u6jemDconK66YPiMGEuJ3C",
                        "created_at": "2025-07-05T13:52:30.000000Z",
                        "updated_at": "2025-07-05T13:52:30.000000Z",
                        "rate": {
                            "rate_id": "e88cd4c8-f244-46d4-bca5-8c495b3ad55d",
                            "open_id": "chefjkhgefoewiwer",
                            "rating": 4.5,
                            "total_ratings": 1,
                            "created_at": "2025-07-05T16:15:33.000000Z",
                            "updated_at": "2025-07-05T16:15:33.000000Z"
                        }
                    },
                    "ingredients_list": [
                        {
                            "ingredient_id": "1459dd25-65b9-42c2-bf29-54d2bc98f17b",
                            "name": "Lemon Juice (freshly squeezed)",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1/4 cup",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "24c6854a-c0ad-4e73-88d5-aaa8a24e4652",
                            "name": "Vegetable Oil",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1/4 cup",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "26967d04-64b2-435b-8f66-52af405dece7",
                            "name": "Cayenne Pepper (optional)",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1/4 teaspoon",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "577ad16b-d755-47a2-a502-e96b66e5e0e7",
                            "name": "Ginger",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1 tablespoon, grated",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "a071a657-dd1e-408b-8838-08d97e8d57e3",
                            "name": "Garlic",
                            "image": "https://images.unsplash.com/photo-1502741338009-cac2772e18bc",
                            "quantity": "4 cloves, minced",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "b400169b-9b58-4473-92a9-c3a47a4a421e",
                            "name": "Curry Powder",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 teaspoon",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "bcf9684f-395d-4c2c-96cc-fcb60143b7a6",
                            "name": "Goat Meat (Nyama Choma Classic)",
                            "image": "https://halalmeatnj.com/cdn/shop/files/00690085390334.jpg?v=1740430667",
                            "quantity": "1 Kg",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "bcfcc87d-3e70-4ab4-90ed-6f44271f143d",
                            "name": "Rosemary (fresh or dried)",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1 teaspoon, minced",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "cf9a851e-832c-4b56-b914-b4d1e784211e",
                            "name": "Bouillon Powder or Soy Sauce",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 teaspoon bouillon powder or 1 tablespoon soy sauce",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "e6b85863-10f1-4be5-9aa7-f50a3186ab01",
                            "name": "Paprika",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 tablespoon",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "e9506089-d5d4-4acd-86fc-809536ce2cbf",
                            "name": "Salt",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "to taste",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        },
                        {
                            "ingredient_id": "fe201314-ed73-4b81-87f5-c4a80af20f84",
                            "name": "Black Pepper",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "to taste",
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z"
                        }
                    ]
                },
                {
                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                    "name": "Nyama Choma",
                    "description": "Nyama Choma is a delicious Kenyan goat meat delicacy you can enjoy any time of the day. It is nutritious, versatile, and oh-so finger-licking good!",
                    "image": "https://cdn.foodandmeal.com/wp-content/uploads/2023/10/3.1-1-3.jpg?strip=all&lossy=1&ssl=1",
                    "open_id": "chefjkhgefoewiwer",
                    "instructions": "1. Wash and drain the goat meat, then cut them into smaller bite sizes. 2.Pour your oil and spices into a mixing bowl and mix them. 3. Blend the onions and garlic coarsely in a food processor, or finely chop them if you prefer. 4. Put the chunks of meat into the mixing bowl, add the spices, the blended garlic, and onion, and properly mix everything. 5. Marinate it in the fridge for 2 hours or longer. I prefer to let it marinate overnight for even more flavor. 6. Bring it out of the refrigerator and let it come to room temperature. 7. Turn the grill to medium-low heat and arrange the meat on the grill. 8. Add 2 tablespoon of salt to 2 cups of water. Grill the meat for 50 minutes, turning every 10 minutes and basting with the salt water.",
                    "created_at": "2025-07-08T05:31:23.000000Z",
                    "updated_at": "2025-07-08T05:31:23.000000Z",
                    "chef": {
                        "user_id": "a10a3188-4ead-4551-89e9-063edef6e838",
                        "name": "Chef Jon",
                        "email": "chef.john@gmail.com",
                        "open_id": "chefjkhgefoewiwer",
                        "avatar": "https://img.freepik.com/free-photo/chef-cooking-kitchen-while-wearing-professional-attire_23-2151208266.jpg?semt=ais_hybrid&w=740",
                        "role": "Chef",
                        "gender": null,
                        "date_of_birth": null,
                        "phone": null,
                        "phone_complete": null,
                        "country_code": null,
                        "token": "mjOFUkM4DvBgkNcESOvzUimLXLunVIyTUENwLjD1D0CPGC0yEr1ayHbiYEceCMn2L7Y2C5itWxxLp1o9hODJ85jQcNJ031FX211ul",
                        "access_token": "Tmnym86I1YzDoicOaX9PfvRmyQ0cA4VjbyAAnqLm3xBU67ktgOBTGpXyANDXhFOojk49MM23N4OUpy4u6jemDconK66YPiMGEuJ3C",
                        "created_at": "2025-07-05T13:52:30.000000Z",
                        "updated_at": "2025-07-05T13:52:30.000000Z",
                        "rate": {
                            "rate_id": "e88cd4c8-f244-46d4-bca5-8c495b3ad55d",
                            "open_id": "chefjkhgefoewiwer",
                            "rating": 4.5,
                            "total_ratings": 1,
                            "created_at": "2025-07-05T16:15:33.000000Z",
                            "updated_at": "2025-07-05T16:15:33.000000Z"
                        }
                    },
                    "ingredients_list": [
                        {
                            "ingredient_id": "11207e60-b312-49c0-81b8-c7433db3b821",
                            "name": "Bouillon Powder or Soy Sauce",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 teaspoon bouillon powder or 1 tablespoon soy sauce",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "1b86cc2c-ce34-463f-890c-c039fa2aaf4c",
                            "name": "Vegetable Oil",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1/4 cup",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "473632f0-0e36-4570-ad73-352793d1e64e",
                            "name": "Rosemary (fresh or dried)",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1 teaspoon, minced",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "584c9dfb-95af-49d1-b4d4-fd90d3231789",
                            "name": "Goat Meat (Nyama Choma Classic)",
                            "image": "https://halalmeatnj.com/cdn/shop/files/00690085390334.jpg?v=1740430667",
                            "quantity": "1 Kg",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "69fe5a05-32a0-48bb-8cc8-4ef4188dbed4",
                            "name": "Curry Powder",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 teaspoon",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "77ba5f7b-e116-4b23-ba6f-d088bc19c7d8",
                            "name": "Paprika",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1 tablespoon",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "99736d35-964f-4ba9-ae08-aa6712830a51",
                            "name": "Ginger",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1 tablespoon, grated",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "b709c97f-78ca-4790-98fe-3231f5d2c046",
                            "name": "Black Pepper",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "to taste",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "c8ef9d15-8b8b-4412-ac95-bbb22a5fa1e3",
                            "name": "Salt",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "to taste",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "cf261ef5-068b-45dc-a7a9-9b25957afa96",
                            "name": "Lemon Juice (freshly squeezed)",
                            "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                            "quantity": "1/4 cup",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "de7d390d-7a60-4a88-ac05-b49e2ba9cecd",
                            "name": "Garlic",
                            "image": "https://images.unsplash.com/photo-1502741338009-cac2772e18bc",
                            "quantity": "4 cloves, minced",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        },
                        {
                            "ingredient_id": "e57d0944-aca6-4b72-9701-0b01c0fc6980",
                            "name": "Cayenne Pepper (optional)",
                            "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                            "quantity": "1/4 teaspoon",
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z"
                        }
                    ]
                }
            ],
            "popular_chefs": [
                {
                    "user_id": "a10a3188-4ead-4551-89e9-063edef6e838",
                    "name": "Chef Jon",
                    "email": "chef.john@gmail.com",
                    "open_id": "chefjkhgefoewiwer",
                    "avatar": "https://img.freepik.com/free-photo/chef-cooking-kitchen-while-wearing-professional-attire_23-2151208266.jpg?semt=ais_hybrid&w=740",
                    "role": "Chef",
                    "gender": null,
                    "date_of_birth": null,
                    "phone": null,
                    "phone_complete": null,
                    "country_code": null,
                    "token": "mjOFUkM4DvBgkNcESOvzUimLXLunVIyTUENwLjD1D0CPGC0yEr1ayHbiYEceCMn2L7Y2C5itWxxLp1o9hODJ85jQcNJ031FX211ul",
                    "access_token": "Tmnym86I1YzDoicOaX9PfvRmyQ0cA4VjbyAAnqLm3xBU67ktgOBTGpXyANDXhFOojk49MM23N4OUpy4u6jemDconK66YPiMGEuJ3C",
                    "created_at": "2025-07-05T13:52:30.000000Z",
                    "updated_at": "2025-07-05T13:52:30.000000Z",
                    "recipes_list": [
                        {
                            "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                            "name": "Nyama Choma",
                            "description": "Nyama Choma is a delicious Kenyan goat meat delicacy you can enjoy any time of the day. It is nutritious, versatile, and oh-so finger-licking good!",
                            "image": "https://cdn.foodandmeal.com/wp-content/uploads/2023/10/3.1-1-3.jpg?strip=all&lossy=1&ssl=1",
                            "open_id": "chefjkhgefoewiwer",
                            "instructions": "1. Wash and drain the goat meat, then cut them into smaller bite sizes. 2.Pour your oil and spices into a mixing bowl and mix them. 3. Blend the onions and garlic coarsely in a food processor, or finely chop them if you prefer. 4. Put the chunks of meat into the mixing bowl, add the spices, the blended garlic, and onion, and properly mix everything. 5. Marinate it in the fridge for 2 hours or longer. I prefer to let it marinate overnight for even more flavor. 6. Bring it out of the refrigerator and let it come to room temperature. 7. Turn the grill to medium-low heat and arrange the meat on the grill. 8. Add 2 tablespoon of salt to 2 cups of water. Grill the meat for 50 minutes, turning every 10 minutes and basting with the salt water.",
                            "created_at": "2025-07-08T05:31:23.000000Z",
                            "updated_at": "2025-07-08T05:31:23.000000Z",
                            "ingredients_list": [
                                {
                                    "ingredient_id": "11207e60-b312-49c0-81b8-c7433db3b821",
                                    "name": "Bouillon Powder or Soy Sauce",
                                    "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                                    "quantity": "1 teaspoon bouillon powder or 1 tablespoon soy sauce",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                },
                                {
                                    "ingredient_id": "1b86cc2c-ce34-463f-890c-c039fa2aaf4c",
                                    "name": "Vegetable Oil",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "1/4 cup",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                },
                                {
                                    "ingredient_id": "473632f0-0e36-4570-ad73-352793d1e64e",
                                    "name": "Rosemary (fresh or dried)",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "1 teaspoon, minced",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                },
                                {
                                    "ingredient_id": "584c9dfb-95af-49d1-b4d4-fd90d3231789",
                                    "name": "Goat Meat (Nyama Choma Classic)",
                                    "image": "https://halalmeatnj.com/cdn/shop/files/00690085390334.jpg?v=1740430667",
                                    "quantity": "1 Kg",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                },
                                {
                                    "ingredient_id": "69fe5a05-32a0-48bb-8cc8-4ef4188dbed4",
                                    "name": "Curry Powder",
                                    "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                                    "quantity": "1 teaspoon",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                },
                                {
                                    "ingredient_id": "77ba5f7b-e116-4b23-ba6f-d088bc19c7d8",
                                    "name": "Paprika",
                                    "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                                    "quantity": "1 tablespoon",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                },
                                {
                                    "ingredient_id": "99736d35-964f-4ba9-ae08-aa6712830a51",
                                    "name": "Ginger",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "1 tablespoon, grated",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                },
                                {
                                    "ingredient_id": "b709c97f-78ca-4790-98fe-3231f5d2c046",
                                    "name": "Black Pepper",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "to taste",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                },
                                {
                                    "ingredient_id": "c8ef9d15-8b8b-4412-ac95-bbb22a5fa1e3",
                                    "name": "Salt",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "to taste",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                },
                                {
                                    "ingredient_id": "cf261ef5-068b-45dc-a7a9-9b25957afa96",
                                    "name": "Lemon Juice (freshly squeezed)",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "1/4 cup",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                },
                                {
                                    "ingredient_id": "de7d390d-7a60-4a88-ac05-b49e2ba9cecd",
                                    "name": "Garlic",
                                    "image": "https://images.unsplash.com/photo-1502741338009-cac2772e18bc",
                                    "quantity": "4 cloves, minced",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                },
                                {
                                    "ingredient_id": "e57d0944-aca6-4b72-9701-0b01c0fc6980",
                                    "name": "Cayenne Pepper (optional)",
                                    "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                                    "quantity": "1/4 teaspoon",
                                    "recipe_id": "bf9c9d3d-014d-479e-b3bc-aad90f359ea6",
                                    "created_at": "2025-07-08T05:31:23.000000Z",
                                    "updated_at": "2025-07-08T05:31:23.000000Z"
                                }
                            ]
                        },
                        {
                            "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                            "name": "Nyama Choma",
                            "description": "Nyama Choma is a delicious Kenyan goat meat delicacy you can enjoy any time of the day. It is nutritious, versatile, and oh-so finger-licking good!",
                            "image": "https://cdn.foodandmeal.com/wp-content/uploads/2023/10/3.1-1-3.jpg?strip=all&lossy=1&ssl=1",
                            "open_id": "chefjkhgefoewiwer",
                            "instructions": "1. Wash and drain the goat meat, then cut them into smaller bite sizes. 2.Pour your oil and spices into a mixing bowl and mix them. 3. Blend the onions and garlic coarsely in a food processor, or finely chop them if you prefer. 4. Put the chunks of meat into the mixing bowl, add the spices, the blended garlic, and onion, and properly mix everything. 5. Marinate it in the fridge for 2 hours or longer. I prefer to let it marinate overnight for even more flavor. 6. Bring it out of the refrigerator and let it come to room temperature. 7. Turn the grill to medium-low heat and arrange the meat on the grill. 8. Add 2 tablespoon of salt to 2 cups of water. Grill the meat for 50 minutes, turning every 10 minutes and basting with the salt water.",
                            "created_at": "2025-07-05T16:13:38.000000Z",
                            "updated_at": "2025-07-05T16:13:38.000000Z",
                            "ingredients_list": [
                                {
                                    "ingredient_id": "1459dd25-65b9-42c2-bf29-54d2bc98f17b",
                                    "name": "Lemon Juice (freshly squeezed)",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "1/4 cup",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                },
                                {
                                    "ingredient_id": "24c6854a-c0ad-4e73-88d5-aaa8a24e4652",
                                    "name": "Vegetable Oil",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "1/4 cup",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                },
                                {
                                    "ingredient_id": "26967d04-64b2-435b-8f66-52af405dece7",
                                    "name": "Cayenne Pepper (optional)",
                                    "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                                    "quantity": "1/4 teaspoon",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                },
                                {
                                    "ingredient_id": "577ad16b-d755-47a2-a502-e96b66e5e0e7",
                                    "name": "Ginger",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "1 tablespoon, grated",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                },
                                {
                                    "ingredient_id": "a071a657-dd1e-408b-8838-08d97e8d57e3",
                                    "name": "Garlic",
                                    "image": "https://images.unsplash.com/photo-1502741338009-cac2772e18bc",
                                    "quantity": "4 cloves, minced",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                },
                                {
                                    "ingredient_id": "b400169b-9b58-4473-92a9-c3a47a4a421e",
                                    "name": "Curry Powder",
                                    "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                                    "quantity": "1 teaspoon",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                },
                                {
                                    "ingredient_id": "bcf9684f-395d-4c2c-96cc-fcb60143b7a6",
                                    "name": "Goat Meat (Nyama Choma Classic)",
                                    "image": "https://halalmeatnj.com/cdn/shop/files/00690085390334.jpg?v=1740430667",
                                    "quantity": "1 Kg",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                },
                                {
                                    "ingredient_id": "bcfcc87d-3e70-4ab4-90ed-6f44271f143d",
                                    "name": "Rosemary (fresh or dried)",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "1 teaspoon, minced",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                },
                                {
                                    "ingredient_id": "cf9a851e-832c-4b56-b914-b4d1e784211e",
                                    "name": "Bouillon Powder or Soy Sauce",
                                    "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                                    "quantity": "1 teaspoon bouillon powder or 1 tablespoon soy sauce",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                },
                                {
                                    "ingredient_id": "e6b85863-10f1-4be5-9aa7-f50a3186ab01",
                                    "name": "Paprika",
                                    "image": "https://images.unsplash.com/photo-1519864600265-abb23847ef2c",
                                    "quantity": "1 tablespoon",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                },
                                {
                                    "ingredient_id": "e9506089-d5d4-4acd-86fc-809536ce2cbf",
                                    "name": "Salt",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "to taste",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                },
                                {
                                    "ingredient_id": "fe201314-ed73-4b81-87f5-c4a80af20f84",
                                    "name": "Black Pepper",
                                    "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                                    "quantity": "to taste",
                                    "recipe_id": "db1ba7e2-ff2d-426f-9b50-e79ed622481e",
                                    "created_at": "2025-07-05T16:13:38.000000Z",
                                    "updated_at": "2025-07-05T16:13:38.000000Z"
                                }
                            ]
                        }
                    ],
                    "all_rates": [
                        {
                            "rate_id": "a3e6a64a-4dc4-4b6f-b627-7a5347c4e811",
                            "ratee_id": "chefjkhgefoewiwer",
                            "rater_id": "custkwdjedvghe",
                            "rating": 4.5,
                            "comment": "Good meals Yes",
                            "created_at": "2025-07-05T16:15:33.000000Z",
                            "updated_at": "2025-07-05T16:15:33.000000Z",
                            "rater": {
                                "user_id": "ceab6ea6-e82a-45f4-abe3-47718ba890a7",
                                "name": "James Doe",
                                "email": "james.doe@gmail.com",
                                "open_id": "custkwdjedvghe",
                                "avatar": "/images/profile/default.png",
                                "role": "Customer",
                                "gender": null,
                                "date_of_birth": null,
                                "phone": null,
                                "phone_complete": null,
                                "country_code": null,
                                "token": "nGz9WZMtRxay4KK5gSKujWC21RobbSYGpMGIenIWvrqT3tlWp8SBj19sVBZDQy4lVt3N5DXH7Hc9D6MtukBlZw3fE9xuAAxhgrzWE",
                                "access_token": "yz5PtzBOf2L9tw4w5NY4OHNmzAE4LAVwVzzSfi8QKAwQXAOPjwoDc9h9pXnGXI3MsQuKldMKJKDGYKngxpMJ64uRLJEEvWkGi9Q0h",
                                "created_at": "2025-07-05T13:50:23.000000Z",
                                "updated_at": "2025-07-05T13:50:23.000000Z"
                            }
                        }
                    ]
                }
            ]
        }
    }
    """
    
   // static var homeResponseModel = try! JSONDecoder().decode(HomeResponseModel.self, from: DATA.data(using: .utf8)!)
    static var dataModel = DATA.decodeJSON(to: HomeResponseModel.self)
}
