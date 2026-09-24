/*
* Created by Martin Wainaina on 24/09/2026
*
* Feel free to contribute.
*/

//
//  HomeMockData.swift
//  Recipe
//
//  Created by Hummingbird on 08/07/2025.
//

import Foundation

struct HomeMockData {
    var response: String = """
        {
          "message": "Home data fetched successfully.",
          "status_code": 200,
          "data": {
            "just_for_you": [
              {
                "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                "name": "Nyama Choma",
                "description": "Nyama Choma is a delicious Kenyan goat meat delicacy you can enjoy any time of the day. It is nutritious, versatile, and oh-so finger-licking good!",
                "image": "https://cdn.foodandmeal.com/wp-content/uploads/2023/10/3.1-1-3.jpg?strip=all&lossy=1&ssl=1",
                "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                "instructions": "1. Wash and drain the goat meat, then cut them into smaller bite sizes. 2.Pour your oil and spices into a mixing bowl and mix them. 3. Blend the onions and garlic coarsely in a food processor, or finely chop them if you prefer. 4. Put the chunks of meat into the mixing bowl, add the spices, the blended garlic, and onion, and properly mix everything. 5. Marinate it in the fridge for 2 hours or longer. I prefer to let it marinate overnight for even more flavor. 6. Bring it out of the refrigerator and let it come to room temperature. 7. Turn the grill to medium-low heat and arrange the meat on the grill. 8. Add 2 tablespoon of salt to 2 cups of water. Grill the meat for 50 minutes, turning every 10 minutes and basting with the salt water.",
                "created_at": "2025-08-23T06:40:28.000000Z",
                "updated_at": "2025-08-23T06:40:28.000000Z",
                "chef": {
                  "user_id": "2404671c-923d-4d4c-a514-8b507882341f",
                  "name": "Chef  Wainaina",
                  "email": "timizalab@gmail.com",
                  "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                  "avatar": "/images/profile/chef_avatar.png",
                  "role": "Chef",
                  "gender": null,
                  "auth_type": "Google",
                  "date_of_birth": null,
                  "phone": null,
                  "phone_complete": null,
                  "country_code": null,
                  "token": "1XDZypk033PrKwNNs0P7dI9W0R0WnbrGyml1T6yVTshv740k67MTHLntHkIPkLVXV0dPuIrHgN3ut6opAHv7uz0wa5R7gJLOia5iU",
                  "access_token": "oSN93zwfhatQzDtxd6COMxVhfavkoIrtKyx7AVnxcyt04pHhSK3wJ4HHySyZwZHUsJv4LmECXmosqXwQvf2Y6Ik4Lvd3UZs6wxV2w",
                  "created_at": "2025-08-23T06:10:05.000000Z",
                  "updated_at": "2025-08-23T06:10:05.000000Z",
                  "rate": {
                    "rate_id": "86817d49-dde9-4e97-b993-196b430fb5fb",
                    "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "rating": 4.333333333333333,
                    "total_ratings": 3,
                    "created_at": "2025-08-24T18:38:29.000000Z",
                    "updated_at": "2025-09-07T09:02:20.000000Z"
                  }
                },
                "ingredients_list": [
                  {
                    "ingredient_id": "01aebbf7-43f5-4bb7-88e8-faefadb2c29e",
                    "name": "Salt",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRaY7l33pRQSrOYXDvKsOIfUsHvlp154XzyA&s",
                    "quantity": "to taste",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "43ec49f5-349d-4052-9e82-42a70d41d79a",
                    "name": "Rosemary (fresh or dried)",
                    "image": "https://cdn.mafrservices.com/sys-master-root/h2b/h1e/31009212596254/146405_main.jpg?im=Resize=480",
                    "quantity": "1 teaspoon, minced",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "478bc0f2-1a98-4a68-854d-a73168012d82",
                    "name": "Curry Powder",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTItv5y9l5dcWD8ox-XLMrNSeapXgzo63aTw&s",
                    "quantity": "1 teaspoon",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "8b31b267-d6ab-486f-b233-04461cc81156",
                    "name": "Goat Meat (Nyama Choma Classic)",
                    "image": "https://halalmeatnj.com/cdn/shop/files/00690085390334.jpg?v=1740430667",
                    "quantity": "1 Kg",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "96a38099-e0f3-4016-b5bf-847c1e7ddda9",
                    "name": "Vegetable Oil",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRn3_fiPyVLcTtgnXpxBYeUJPmk_aQjSDBcA&s",
                    "quantity": "1/4 cup",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "9d87c221-f6f8-4456-a690-01eeeb29e2d5",
                    "name": "Paprika",
                    "image": "https://freshgrain.net/wp-content/uploads/2023/11/PAPRIKA.png",
                    "quantity": "1 tablespoon",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "cbcc3368-cb5e-45df-8a69-c3adc4baa848",
                    "name": "Bouillon Powder or Soy Sauce",
                    "image": "https://www.mapleandmango.com/wp-content/uploads/2021/09/bouillon-powder-feature.jpg",
                    "quantity": "1 teaspoon bouillon powder or 1 tablespoon soy sauce",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "ccb5e7f2-bf1a-4cd2-87a4-15b27c5fe632",
                    "name": "Lemon Juice (freshly squeezed)",
                    "image": "https://lirp.cdn-website.com/7a5d8045/dms3rep/multi/opt/lemon+Juice-640w.webp",
                    "quantity": "1/4 cup",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "e087ed34-da0b-4b5e-ac78-617bcd634572",
                    "name": "Black Pepper",
                    "image": "https://www.terraearthfood.com/cdn/shop/products/TerraBlackPepperPowder_1_d33b2385-e608-4b2c-830e-252c2de9773c_1024x1024.jpg?v=1626012511",
                    "quantity": "to taste",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "e385aeb7-0789-4f88-8cc0-a4fe8750ed9f",
                    "name": "Garlic",
                    "image": "https://www.veggycation.com.au/siteassets/veggycationvegetable/garlic.jpg",
                    "quantity": "4 cloves, minced",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "f2e48622-07ff-440d-965b-8eb4acaf270d",
                    "name": "Cayenne Pepper (optional)",
                    "image": "https://images.medicinenet.com/images/article/main_image/cayenne-pepper.jpg?output-quality=75",
                    "quantity": "1/4 teaspoon",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "fe2eb683-bd87-4782-be3b-478bc8a0fd25",
                    "name": "Ginger",
                    "image": "https://www.vitaeinternational.com/wp-content/uploads/2015/12/benefits-of-ginger.jpg",
                    "quantity": "1 tablespoon, grated",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  }
                ]
              },
              {
                "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                "name": "Ratatouille",
                "description": "A vegetable medley from Provence made with eggplant, zucchini, bell peppers, tomatoes, and herbs. Healthy, colorful, and bursting with flavor.",
                "image": "https://cookingorgeous.com/wp-content/uploads/2021/08/ratatouille-nicoise-30.jpg",
                "open_id": "yzuITvR4p1fYMn0tiC1yyalPogu1",
                "instructions": "1. Heat olive oil in a pan. 2. Sauté onions and garlic until soft. 3. Add eggplant, zucchini, and peppers, cook for 10 minutes. 4. Add tomatoes and herbs, simmer for 20 minutes. 5. Adjust seasoning with salt and pepper. 6. Serve hot with bread or as a side dish.",
                "created_at": "2025-08-23T08:42:09.000000Z",
                "updated_at": "2025-08-23T08:42:09.000000Z",
                "chef": {
                  "user_id": "de00b711-11b7-44b0-9c92-0cbe7d1f0ad9",
                  "name": "Safiri Chefs",
                  "email": "safiribytes@gmail.com",
                  "open_id": "yzuITvR4p1fYMn0tiC1yyalPogu1",
                  "avatar": "/images/profile/chef_avatar.png",
                  "role": "Chef",
                  "gender": null,
                  "auth_type": "Email",
                  "date_of_birth": null,
                  "phone": null,
                  "phone_complete": null,
                  "country_code": null,
                  "token": "te3sh8selC1FBOoLrheBGFNJ9lIUypBu0iesndBJNmPlb6xhUipLwynO1ZtR0GSm4ppxUKKW4fnA7LSRuBDwUZKk4oZMOReJKi0gz",
                  "access_token": "Y4lcaRkQnlebYkJtfNoMTl8LtOLuuqkgWIlzCB249EkcEo5NygVKRtWa9nXatpJaEmCjpMgiCdGzA1X5rHwIdxtQFJAiJ9fLKExvY",
                  "created_at": "2025-08-23T08:29:07.000000Z",
                  "updated_at": "2025-08-23T08:29:07.000000Z",
                  "rate": null
                },
                "ingredients_list": [
                  {
                    "ingredient_id": "0fdedac6-86d6-45f8-a5d9-6ca3f4adb4b8",
                    "name": "Olive Oil",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRn3_fiPyVLcTtgnXpxBYeUJPmk_aQjSDBcA&s",
                    "quantity": "4 tablespoons",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "2941d897-489e-4814-8cab-749be90fe981",
                    "name": "Onion",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAQyyA1MHofXz2r1opzUjfDBKeutCoAmUNqQ&s",
                    "quantity": "1, chopped",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "2c69e678-329d-4e72-8031-451b9d316078",
                    "name": "Bell Peppers (red & yellow)",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZVYa_RBlmhm9U4LPivanbeLe4aZ1PHG_JJQ&s",
                    "quantity": "2, sliced",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "3aafc5f9-f76f-4523-855e-e0fa9f7f39b7",
                    "name": "Zucchini",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNZ2hJYtaYVZYq1AdkzdUAK3kPZ8hUjFkz7A&s",
                    "quantity": "2 medium, sliced",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "5f23608c-638a-4c0c-8778-a2ce01af4f9b",
                    "name": "Tomatoes",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5B62fXmxWeGjDSdcvmGf3WP1QAb9Duqty2A&s",
                    "quantity": "4 large, chopped",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "a3c851a4-06da-4735-b289-208ddd002839",
                    "name": "Eggplant",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7K5A41Y2QT8db6KbhiE8xrCzSQCNk_7egIA&s",
                    "quantity": "2 medium, diced",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "de28654e-d7fb-4c3f-bc3d-998b91dfd264",
                    "name": "Herbs de Provence",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSB7nzI8PwbLVcPAUWmXyR05wemPsSABnpQ3A&s",
                    "quantity": "1 tablespoon",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  }
                ]
              },
              {
                "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                "name": "Coq au Vin",
                "description": "A traditional French dish made with chicken braised in red wine with mushrooms, onions, and herbs. Rich, comforting, and perfect for a family dinner.",
                "image": "https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/k%2FPhoto%2FRecipes%2F2024-10-coq-au-vin%2Fcoq-au-vin-083-vertical",
                "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                "instructions": "1. Marinate chicken in wine with herbs overnight. 2. Fry bacon until crispy. Remove and set aside. 3. Brown chicken in the same pan. 4. Add onions, garlic, and mushrooms, cook until softened. 5. Pour in wine and simmer with thyme and bay leaves. 6. Cook for 1.5–2 hours until chicken is tender. 7. Serve hot with mashed potatoes or crusty bread.",
                "created_at": "2025-08-23T08:14:59.000000Z",
                "updated_at": "2025-08-23T08:14:59.000000Z",
                "chef": {
                  "user_id": "2404671c-923d-4d4c-a514-8b507882341f",
                  "name": "Chef  Wainaina",
                  "email": "timizalab@gmail.com",
                  "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                  "avatar": "/images/profile/chef_avatar.png",
                  "role": "Chef",
                  "gender": null,
                  "auth_type": "Google",
                  "date_of_birth": null,
                  "phone": null,
                  "phone_complete": null,
                  "country_code": null,
                  "token": "1XDZypk033PrKwNNs0P7dI9W0R0WnbrGyml1T6yVTshv740k67MTHLntHkIPkLVXV0dPuIrHgN3ut6opAHv7uz0wa5R7gJLOia5iU",
                  "access_token": "oSN93zwfhatQzDtxd6COMxVhfavkoIrtKyx7AVnxcyt04pHhSK3wJ4HHySyZwZHUsJv4LmECXmosqXwQvf2Y6Ik4Lvd3UZs6wxV2w",
                  "created_at": "2025-08-23T06:10:05.000000Z",
                  "updated_at": "2025-08-23T06:10:05.000000Z",
                  "rate": {
                    "rate_id": "86817d49-dde9-4e97-b993-196b430fb5fb",
                    "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "rating": 4.333333333333333,
                    "total_ratings": 3,
                    "created_at": "2025-08-24T18:38:29.000000Z",
                    "updated_at": "2025-09-07T09:02:20.000000Z"
                  }
                },
                "ingredients_list": [
                  {
                    "ingredient_id": "30cae55a-e01e-40d6-97b3-b03cab308ec7",
                    "name": "Garlic",
                    "image": "https://www.veggycation.com.au/siteassets/veggycationvegetable/garlic.jpg",
                    "quantity": "3 cloves, minced",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "4e81d015-4999-4bf9-9899-74db207d1238",
                    "name": "Red Wine",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmp8tS9VMnXOMEV28gitwMd8QEE0Q0WwMxIw&s",
                    "quantity": "750 ml",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "8e1703a1-baa2-4d64-ae13-e0ff321d2929",
                    "name": "Mushrooms",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5bqr81wEhkl16OiTz5PGo7asbwqWJffGxHw&s",
                    "quantity": "250 g, sliced",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "95e55271-9d63-4fe7-95a2-91d2c1215216",
                    "name": "Bacon",
                    "image": "https://amazingribs.com/wp-content/uploads/2012/05/canadian-bacon.jpg",
                    "quantity": "150 g, diced",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "a8f8050d-9ad3-42cd-b313-b0102d19a515",
                    "name": "Onions (small pearl onions)",
                    "image": "https://image.tuasaude.com/media/article/ru/ny/beneficios-da-cebola_39481.jpg?width=686&height=487",
                    "quantity": "200 g",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "e697b552-eb1d-4d81-91e2-ea95a753b725",
                    "name": "Chicken (cut into pieces)",
                    "image": "https://www.eatthis.com/wp-content/uploads/sites/4/2022/12/whole-cooked-chicken.jpg?quality=82&strip=all",
                    "quantity": "1 whole (about 1.5 kg)",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "f7ac1a4e-2062-41f4-ba58-e2ac0fc8fea0",
                    "name": "Thyme & Bay Leaves",
                    "image": "https://www.acquagarden.co.uk/cdn/shop/files/acquagarden-kitchen-bay-leaf-37888413630619.jpg?v=1725130914&width=900",
                    "quantity": "1 sprig thyme, 2 bay leaves",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  }
                ]
              },
              {
                "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                "name": "Chapati",
                "description": "Kenyan Chapati is a soft, layered flatbread enjoyed with stews, beans, or tea. It is a popular comfort food and festive meal in Kenya.",
                "image": "https://i.ytimg.com/vi/WKD00uAbepk/maxresdefault.jpg",
                "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                "instructions": "1. Mix flour, salt, and sugar in a bowl. 2. Gradually add warm water and oil to make a soft dough. Knead for 10 minutes. 3. Cover and let it rest for 30 minutes. 4. Divide into balls, roll out into circles, brush lightly with oil, fold, and roll again for layered texture. 5. Fry each chapati on a hot pan until golden brown on both sides. 6. Serve warm with stew or beans.",
                "created_at": "2025-08-23T07:53:37.000000Z",
                "updated_at": "2025-08-23T07:53:37.000000Z",
                "chef": {
                  "user_id": "2404671c-923d-4d4c-a514-8b507882341f",
                  "name": "Chef  Wainaina",
                  "email": "timizalab@gmail.com",
                  "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                  "avatar": "/images/profile/chef_avatar.png",
                  "role": "Chef",
                  "gender": null,
                  "auth_type": "Google",
                  "date_of_birth": null,
                  "phone": null,
                  "phone_complete": null,
                  "country_code": null,
                  "token": "1XDZypk033PrKwNNs0P7dI9W0R0WnbrGyml1T6yVTshv740k67MTHLntHkIPkLVXV0dPuIrHgN3ut6opAHv7uz0wa5R7gJLOia5iU",
                  "access_token": "oSN93zwfhatQzDtxd6COMxVhfavkoIrtKyx7AVnxcyt04pHhSK3wJ4HHySyZwZHUsJv4LmECXmosqXwQvf2Y6Ik4Lvd3UZs6wxV2w",
                  "created_at": "2025-08-23T06:10:05.000000Z",
                  "updated_at": "2025-08-23T06:10:05.000000Z",
                  "rate": {
                    "rate_id": "86817d49-dde9-4e97-b993-196b430fb5fb",
                    "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "rating": 4.333333333333333,
                    "total_ratings": 3,
                    "created_at": "2025-08-24T18:38:29.000000Z",
                    "updated_at": "2025-09-07T09:02:20.000000Z"
                  }
                },
                "ingredients_list": [
                  {
                    "ingredient_id": "7f5ca4d8-a27a-438b-a3de-8ebb8857740f",
                    "name": "Sugar",
                    "image": "https://www.thespruceeats.com/thmb/RlMPgkSpqsFGi0wDlJcwy4wYu2Y=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/demerarasugarOllo-1ace15d9396f4e22b5bd3f5867a818e6.jpg",
                    "quantity": "1 teaspoon",
                    "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                    "created_at": "2025-08-23T07:53:37.000000Z",
                    "updated_at": "2025-08-23T07:53:37.000000Z"
                  },
                  {
                    "ingredient_id": "867a2cc7-72cb-4741-a361-c31d8e5bf564",
                    "name": "Salt",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRaY7l33pRQSrOYXDvKsOIfUsHvlp154XzyA&s",
                    "quantity": "to taste",
                    "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                    "created_at": "2025-08-23T07:53:37.000000Z",
                    "updated_at": "2025-08-23T07:53:37.000000Z"
                  },
                  {
                    "ingredient_id": "93cb3d78-fcad-4288-8b11-07ecbb2788e2",
                    "name": "Vegetable Oil",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRn3_fiPyVLcTtgnXpxBYeUJPmk_aQjSDBcA&s",
                    "quantity": "1/4 cup (plus extra for frying)",
                    "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                    "created_at": "2025-08-23T07:53:37.000000Z",
                    "updated_at": "2025-08-23T07:53:37.000000Z"
                  },
                  {
                    "ingredient_id": "a9df9d5d-58e2-4dbf-bb9e-52336e48f3e5",
                    "name": "Water",
                    "image": "https://aussiegold.net.au/wp-content/uploads/2023/10/Pouring-a-fresh-and-clean-water-into-the-glass.jpg",
                    "quantity": "1 cup (warm)",
                    "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                    "created_at": "2025-08-23T07:53:37.000000Z",
                    "updated_at": "2025-08-23T07:53:37.000000Z"
                  },
                  {
                    "ingredient_id": "bb2e6067-4565-4e29-a2e8-149ff37cd2d9",
                    "name": "All-Purpose Flour",
                    "image": "https://greenspoon.co.ke/wp-content/uploads/2022/12/Greenspoon-Kenya-Ajab-Fortified-All-Purpose-Home-Baking-Flour-2kg.jpg",
                    "quantity": "3 cups(depends)",
                    "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                    "created_at": "2025-08-23T07:53:37.000000Z",
                    "updated_at": "2025-08-23T07:53:37.000000Z"
                  }
                ]
              }
            ],
            "trending_recipes": [
              {
                "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                "name": "Chapati",
                "description": "Kenyan Chapati is a soft, layered flatbread enjoyed with stews, beans, or tea. It is a popular comfort food and festive meal in Kenya.",
                "image": "https://i.ytimg.com/vi/WKD00uAbepk/maxresdefault.jpg",
                "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                "instructions": "1. Mix flour, salt, and sugar in a bowl. 2. Gradually add warm water and oil to make a soft dough. Knead for 10 minutes. 3. Cover and let it rest for 30 minutes. 4. Divide into balls, roll out into circles, brush lightly with oil, fold, and roll again for layered texture. 5. Fry each chapati on a hot pan until golden brown on both sides. 6. Serve warm with stew or beans.",
                "created_at": "2025-08-23T07:53:37.000000Z",
                "updated_at": "2025-08-23T07:53:37.000000Z",
                "chef": {
                  "user_id": "2404671c-923d-4d4c-a514-8b507882341f",
                  "name": "Chef  Wainaina",
                  "email": "timizalab@gmail.com",
                  "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                  "avatar": "/images/profile/chef_avatar.png",
                  "role": "Chef",
                  "gender": null,
                  "auth_type": "Google",
                  "date_of_birth": null,
                  "phone": null,
                  "phone_complete": null,
                  "country_code": null,
                  "token": "1XDZypk033PrKwNNs0P7dI9W0R0WnbrGyml1T6yVTshv740k67MTHLntHkIPkLVXV0dPuIrHgN3ut6opAHv7uz0wa5R7gJLOia5iU",
                  "access_token": "oSN93zwfhatQzDtxd6COMxVhfavkoIrtKyx7AVnxcyt04pHhSK3wJ4HHySyZwZHUsJv4LmECXmosqXwQvf2Y6Ik4Lvd3UZs6wxV2w",
                  "created_at": "2025-08-23T06:10:05.000000Z",
                  "updated_at": "2025-08-23T06:10:05.000000Z",
                  "rate": {
                    "rate_id": "86817d49-dde9-4e97-b993-196b430fb5fb",
                    "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "rating": 4.333333333333333,
                    "total_ratings": 3,
                    "created_at": "2025-08-24T18:38:29.000000Z",
                    "updated_at": "2025-09-07T09:02:20.000000Z"
                  }
                },
                "ingredients_list": [
                  {
                    "ingredient_id": "7f5ca4d8-a27a-438b-a3de-8ebb8857740f",
                    "name": "Sugar",
                    "image": "https://www.thespruceeats.com/thmb/RlMPgkSpqsFGi0wDlJcwy4wYu2Y=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/demerarasugarOllo-1ace15d9396f4e22b5bd3f5867a818e6.jpg",
                    "quantity": "1 teaspoon",
                    "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                    "created_at": "2025-08-23T07:53:37.000000Z",
                    "updated_at": "2025-08-23T07:53:37.000000Z"
                  },
                  {
                    "ingredient_id": "867a2cc7-72cb-4741-a361-c31d8e5bf564",
                    "name": "Salt",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRaY7l33pRQSrOYXDvKsOIfUsHvlp154XzyA&s",
                    "quantity": "to taste",
                    "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                    "created_at": "2025-08-23T07:53:37.000000Z",
                    "updated_at": "2025-08-23T07:53:37.000000Z"
                  },
                  {
                    "ingredient_id": "93cb3d78-fcad-4288-8b11-07ecbb2788e2",
                    "name": "Vegetable Oil",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRn3_fiPyVLcTtgnXpxBYeUJPmk_aQjSDBcA&s",
                    "quantity": "1/4 cup (plus extra for frying)",
                    "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                    "created_at": "2025-08-23T07:53:37.000000Z",
                    "updated_at": "2025-08-23T07:53:37.000000Z"
                  },
                  {
                    "ingredient_id": "a9df9d5d-58e2-4dbf-bb9e-52336e48f3e5",
                    "name": "Water",
                    "image": "https://aussiegold.net.au/wp-content/uploads/2023/10/Pouring-a-fresh-and-clean-water-into-the-glass.jpg",
                    "quantity": "1 cup (warm)",
                    "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                    "created_at": "2025-08-23T07:53:37.000000Z",
                    "updated_at": "2025-08-23T07:53:37.000000Z"
                  },
                  {
                    "ingredient_id": "bb2e6067-4565-4e29-a2e8-149ff37cd2d9",
                    "name": "All-Purpose Flour",
                    "image": "https://greenspoon.co.ke/wp-content/uploads/2022/12/Greenspoon-Kenya-Ajab-Fortified-All-Purpose-Home-Baking-Flour-2kg.jpg",
                    "quantity": "3 cups(depends)",
                    "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                    "created_at": "2025-08-23T07:53:37.000000Z",
                    "updated_at": "2025-08-23T07:53:37.000000Z"
                  }
                ]
              },
              {
                "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                "name": "Ratatouille",
                "description": "A vegetable medley from Provence made with eggplant, zucchini, bell peppers, tomatoes, and herbs. Healthy, colorful, and bursting with flavor.",
                "image": "https://cookingorgeous.com/wp-content/uploads/2021/08/ratatouille-nicoise-30.jpg",
                "open_id": "yzuITvR4p1fYMn0tiC1yyalPogu1",
                "instructions": "1. Heat olive oil in a pan. 2. Sauté onions and garlic until soft. 3. Add eggplant, zucchini, and peppers, cook for 10 minutes. 4. Add tomatoes and herbs, simmer for 20 minutes. 5. Adjust seasoning with salt and pepper. 6. Serve hot with bread or as a side dish.",
                "created_at": "2025-08-23T08:42:09.000000Z",
                "updated_at": "2025-08-23T08:42:09.000000Z",
                "chef": {
                  "user_id": "de00b711-11b7-44b0-9c92-0cbe7d1f0ad9",
                  "name": "Safiri Chefs",
                  "email": "safiribytes@gmail.com",
                  "open_id": "yzuITvR4p1fYMn0tiC1yyalPogu1",
                  "avatar": "/images/profile/chef_avatar.png",
                  "role": "Chef",
                  "gender": null,
                  "auth_type": "Email",
                  "date_of_birth": null,
                  "phone": null,
                  "phone_complete": null,
                  "country_code": null,
                  "token": "te3sh8selC1FBOoLrheBGFNJ9lIUypBu0iesndBJNmPlb6xhUipLwynO1ZtR0GSm4ppxUKKW4fnA7LSRuBDwUZKk4oZMOReJKi0gz",
                  "access_token": "Y4lcaRkQnlebYkJtfNoMTl8LtOLuuqkgWIlzCB249EkcEo5NygVKRtWa9nXatpJaEmCjpMgiCdGzA1X5rHwIdxtQFJAiJ9fLKExvY",
                  "created_at": "2025-08-23T08:29:07.000000Z",
                  "updated_at": "2025-08-23T08:29:07.000000Z",
                  "rate": null
                },
                "ingredients_list": [
                  {
                    "ingredient_id": "0fdedac6-86d6-45f8-a5d9-6ca3f4adb4b8",
                    "name": "Olive Oil",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRn3_fiPyVLcTtgnXpxBYeUJPmk_aQjSDBcA&s",
                    "quantity": "4 tablespoons",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "2941d897-489e-4814-8cab-749be90fe981",
                    "name": "Onion",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAQyyA1MHofXz2r1opzUjfDBKeutCoAmUNqQ&s",
                    "quantity": "1, chopped",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "2c69e678-329d-4e72-8031-451b9d316078",
                    "name": "Bell Peppers (red & yellow)",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZVYa_RBlmhm9U4LPivanbeLe4aZ1PHG_JJQ&s",
                    "quantity": "2, sliced",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "3aafc5f9-f76f-4523-855e-e0fa9f7f39b7",
                    "name": "Zucchini",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNZ2hJYtaYVZYq1AdkzdUAK3kPZ8hUjFkz7A&s",
                    "quantity": "2 medium, sliced",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "5f23608c-638a-4c0c-8778-a2ce01af4f9b",
                    "name": "Tomatoes",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5B62fXmxWeGjDSdcvmGf3WP1QAb9Duqty2A&s",
                    "quantity": "4 large, chopped",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "a3c851a4-06da-4735-b289-208ddd002839",
                    "name": "Eggplant",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7K5A41Y2QT8db6KbhiE8xrCzSQCNk_7egIA&s",
                    "quantity": "2 medium, diced",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  },
                  {
                    "ingredient_id": "de28654e-d7fb-4c3f-bc3d-998b91dfd264",
                    "name": "Herbs de Provence",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSB7nzI8PwbLVcPAUWmXyR05wemPsSABnpQ3A&s",
                    "quantity": "1 tablespoon",
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z"
                  }
                ]
              },
              {
                "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                "name": "Nyama Choma",
                "description": "Nyama Choma is a delicious Kenyan goat meat delicacy you can enjoy any time of the day. It is nutritious, versatile, and oh-so finger-licking good!",
                "image": "https://cdn.foodandmeal.com/wp-content/uploads/2023/10/3.1-1-3.jpg?strip=all&lossy=1&ssl=1",
                "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                "instructions": "1. Wash and drain the goat meat, then cut them into smaller bite sizes. 2.Pour your oil and spices into a mixing bowl and mix them. 3. Blend the onions and garlic coarsely in a food processor, or finely chop them if you prefer. 4. Put the chunks of meat into the mixing bowl, add the spices, the blended garlic, and onion, and properly mix everything. 5. Marinate it in the fridge for 2 hours or longer. I prefer to let it marinate overnight for even more flavor. 6. Bring it out of the refrigerator and let it come to room temperature. 7. Turn the grill to medium-low heat and arrange the meat on the grill. 8. Add 2 tablespoon of salt to 2 cups of water. Grill the meat for 50 minutes, turning every 10 minutes and basting with the salt water.",
                "created_at": "2025-08-23T06:40:28.000000Z",
                "updated_at": "2025-08-23T06:40:28.000000Z",
                "chef": {
                  "user_id": "2404671c-923d-4d4c-a514-8b507882341f",
                  "name": "Chef  Wainaina",
                  "email": "timizalab@gmail.com",
                  "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                  "avatar": "/images/profile/chef_avatar.png",
                  "role": "Chef",
                  "gender": null,
                  "auth_type": "Google",
                  "date_of_birth": null,
                  "phone": null,
                  "phone_complete": null,
                  "country_code": null,
                  "token": "1XDZypk033PrKwNNs0P7dI9W0R0WnbrGyml1T6yVTshv740k67MTHLntHkIPkLVXV0dPuIrHgN3ut6opAHv7uz0wa5R7gJLOia5iU",
                  "access_token": "oSN93zwfhatQzDtxd6COMxVhfavkoIrtKyx7AVnxcyt04pHhSK3wJ4HHySyZwZHUsJv4LmECXmosqXwQvf2Y6Ik4Lvd3UZs6wxV2w",
                  "created_at": "2025-08-23T06:10:05.000000Z",
                  "updated_at": "2025-08-23T06:10:05.000000Z",
                  "rate": {
                    "rate_id": "86817d49-dde9-4e97-b993-196b430fb5fb",
                    "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "rating": 4.333333333333333,
                    "total_ratings": 3,
                    "created_at": "2025-08-24T18:38:29.000000Z",
                    "updated_at": "2025-09-07T09:02:20.000000Z"
                  }
                },
                "ingredients_list": [
                  {
                    "ingredient_id": "01aebbf7-43f5-4bb7-88e8-faefadb2c29e",
                    "name": "Salt",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRaY7l33pRQSrOYXDvKsOIfUsHvlp154XzyA&s",
                    "quantity": "to taste",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "43ec49f5-349d-4052-9e82-42a70d41d79a",
                    "name": "Rosemary (fresh or dried)",
                    "image": "https://cdn.mafrservices.com/sys-master-root/h2b/h1e/31009212596254/146405_main.jpg?im=Resize=480",
                    "quantity": "1 teaspoon, minced",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "478bc0f2-1a98-4a68-854d-a73168012d82",
                    "name": "Curry Powder",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTItv5y9l5dcWD8ox-XLMrNSeapXgzo63aTw&s",
                    "quantity": "1 teaspoon",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "8b31b267-d6ab-486f-b233-04461cc81156",
                    "name": "Goat Meat (Nyama Choma Classic)",
                    "image": "https://halalmeatnj.com/cdn/shop/files/00690085390334.jpg?v=1740430667",
                    "quantity": "1 Kg",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "96a38099-e0f3-4016-b5bf-847c1e7ddda9",
                    "name": "Vegetable Oil",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRn3_fiPyVLcTtgnXpxBYeUJPmk_aQjSDBcA&s",
                    "quantity": "1/4 cup",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "9d87c221-f6f8-4456-a690-01eeeb29e2d5",
                    "name": "Paprika",
                    "image": "https://freshgrain.net/wp-content/uploads/2023/11/PAPRIKA.png",
                    "quantity": "1 tablespoon",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "cbcc3368-cb5e-45df-8a69-c3adc4baa848",
                    "name": "Bouillon Powder or Soy Sauce",
                    "image": "https://www.mapleandmango.com/wp-content/uploads/2021/09/bouillon-powder-feature.jpg",
                    "quantity": "1 teaspoon bouillon powder or 1 tablespoon soy sauce",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "ccb5e7f2-bf1a-4cd2-87a4-15b27c5fe632",
                    "name": "Lemon Juice (freshly squeezed)",
                    "image": "https://lirp.cdn-website.com/7a5d8045/dms3rep/multi/opt/lemon+Juice-640w.webp",
                    "quantity": "1/4 cup",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "e087ed34-da0b-4b5e-ac78-617bcd634572",
                    "name": "Black Pepper",
                    "image": "https://www.terraearthfood.com/cdn/shop/products/TerraBlackPepperPowder_1_d33b2385-e608-4b2c-830e-252c2de9773c_1024x1024.jpg?v=1626012511",
                    "quantity": "to taste",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "e385aeb7-0789-4f88-8cc0-a4fe8750ed9f",
                    "name": "Garlic",
                    "image": "https://www.veggycation.com.au/siteassets/veggycationvegetable/garlic.jpg",
                    "quantity": "4 cloves, minced",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "f2e48622-07ff-440d-965b-8eb4acaf270d",
                    "name": "Cayenne Pepper (optional)",
                    "image": "https://images.medicinenet.com/images/article/main_image/cayenne-pepper.jpg?output-quality=75",
                    "quantity": "1/4 teaspoon",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  },
                  {
                    "ingredient_id": "fe2eb683-bd87-4782-be3b-478bc8a0fd25",
                    "name": "Ginger",
                    "image": "https://www.vitaeinternational.com/wp-content/uploads/2015/12/benefits-of-ginger.jpg",
                    "quantity": "1 tablespoon, grated",
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z"
                  }
                ]
              },
              {
                "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                "name": "Coq au Vin",
                "description": "A traditional French dish made with chicken braised in red wine with mushrooms, onions, and herbs. Rich, comforting, and perfect for a family dinner.",
                "image": "https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/k%2FPhoto%2FRecipes%2F2024-10-coq-au-vin%2Fcoq-au-vin-083-vertical",
                "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                "instructions": "1. Marinate chicken in wine with herbs overnight. 2. Fry bacon until crispy. Remove and set aside. 3. Brown chicken in the same pan. 4. Add onions, garlic, and mushrooms, cook until softened. 5. Pour in wine and simmer with thyme and bay leaves. 6. Cook for 1.5–2 hours until chicken is tender. 7. Serve hot with mashed potatoes or crusty bread.",
                "created_at": "2025-08-23T08:14:59.000000Z",
                "updated_at": "2025-08-23T08:14:59.000000Z",
                "chef": {
                  "user_id": "2404671c-923d-4d4c-a514-8b507882341f",
                  "name": "Chef  Wainaina",
                  "email": "timizalab@gmail.com",
                  "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                  "avatar": "/images/profile/chef_avatar.png",
                  "role": "Chef",
                  "gender": null,
                  "auth_type": "Google",
                  "date_of_birth": null,
                  "phone": null,
                  "phone_complete": null,
                  "country_code": null,
                  "token": "1XDZypk033PrKwNNs0P7dI9W0R0WnbrGyml1T6yVTshv740k67MTHLntHkIPkLVXV0dPuIrHgN3ut6opAHv7uz0wa5R7gJLOia5iU",
                  "access_token": "oSN93zwfhatQzDtxd6COMxVhfavkoIrtKyx7AVnxcyt04pHhSK3wJ4HHySyZwZHUsJv4LmECXmosqXwQvf2Y6Ik4Lvd3UZs6wxV2w",
                  "created_at": "2025-08-23T06:10:05.000000Z",
                  "updated_at": "2025-08-23T06:10:05.000000Z",
                  "rate": {
                    "rate_id": "86817d49-dde9-4e97-b993-196b430fb5fb",
                    "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "rating": 4.333333333333333,
                    "total_ratings": 3,
                    "created_at": "2025-08-24T18:38:29.000000Z",
                    "updated_at": "2025-09-07T09:02:20.000000Z"
                  }
                },
                "ingredients_list": [
                  {
                    "ingredient_id": "30cae55a-e01e-40d6-97b3-b03cab308ec7",
                    "name": "Garlic",
                    "image": "https://www.veggycation.com.au/siteassets/veggycationvegetable/garlic.jpg",
                    "quantity": "3 cloves, minced",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "4e81d015-4999-4bf9-9899-74db207d1238",
                    "name": "Red Wine",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmp8tS9VMnXOMEV28gitwMd8QEE0Q0WwMxIw&s",
                    "quantity": "750 ml",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "8e1703a1-baa2-4d64-ae13-e0ff321d2929",
                    "name": "Mushrooms",
                    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5bqr81wEhkl16OiTz5PGo7asbwqWJffGxHw&s",
                    "quantity": "250 g, sliced",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "95e55271-9d63-4fe7-95a2-91d2c1215216",
                    "name": "Bacon",
                    "image": "https://amazingribs.com/wp-content/uploads/2012/05/canadian-bacon.jpg",
                    "quantity": "150 g, diced",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "a8f8050d-9ad3-42cd-b313-b0102d19a515",
                    "name": "Onions (small pearl onions)",
                    "image": "https://image.tuasaude.com/media/article/ru/ny/beneficios-da-cebola_39481.jpg?width=686&height=487",
                    "quantity": "200 g",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "e697b552-eb1d-4d81-91e2-ea95a753b725",
                    "name": "Chicken (cut into pieces)",
                    "image": "https://www.eatthis.com/wp-content/uploads/sites/4/2022/12/whole-cooked-chicken.jpg?quality=82&strip=all",
                    "quantity": "1 whole (about 1.5 kg)",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  },
                  {
                    "ingredient_id": "f7ac1a4e-2062-41f4-ba58-e2ac0fc8fea0",
                    "name": "Thyme & Bay Leaves",
                    "image": "https://www.acquagarden.co.uk/cdn/shop/files/acquagarden-kitchen-bay-leaf-37888413630619.jpg?v=1725130914&width=900",
                    "quantity": "1 sprig thyme, 2 bay leaves",
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z"
                  }
                ]
              }
            ],
            "popular_chefs": [
              {
                "user_id": "2404671c-923d-4d4c-a514-8b507882341f",
                "name": "Chef  Wainaina",
                "email": "timizalab@gmail.com",
                "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                "avatar": "/images/profile/chef_avatar.png",
                "role": "Chef",
                "gender": null,
                "auth_type": "Google",
                "date_of_birth": null,
                "phone": null,
                "phone_complete": null,
                "country_code": null,
                "token": "1XDZypk033PrKwNNs0P7dI9W0R0WnbrGyml1T6yVTshv740k67MTHLntHkIPkLVXV0dPuIrHgN3ut6opAHv7uz0wa5R7gJLOia5iU",
                "access_token": "oSN93zwfhatQzDtxd6COMxVhfavkoIrtKyx7AVnxcyt04pHhSK3wJ4HHySyZwZHUsJv4LmECXmosqXwQvf2Y6Ik4Lvd3UZs6wxV2w",
                "created_at": "2025-08-23T06:10:05.000000Z",
                "updated_at": "2025-08-23T06:10:05.000000Z",
                "recipes_list": [
                  {
                    "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                    "name": "Chapati",
                    "description": "Kenyan Chapati is a soft, layered flatbread enjoyed with stews, beans, or tea. It is a popular comfort food and festive meal in Kenya.",
                    "image": "https://i.ytimg.com/vi/WKD00uAbepk/maxresdefault.jpg",
                    "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "instructions": "1. Mix flour, salt, and sugar in a bowl. 2. Gradually add warm water and oil to make a soft dough. Knead for 10 minutes. 3. Cover and let it rest for 30 minutes. 4. Divide into balls, roll out into circles, brush lightly with oil, fold, and roll again for layered texture. 5. Fry each chapati on a hot pan until golden brown on both sides. 6. Serve warm with stew or beans.",
                    "created_at": "2025-08-23T07:53:37.000000Z",
                    "updated_at": "2025-08-23T07:53:37.000000Z",
                    "ingredients_list": [
                      {
                        "ingredient_id": "7f5ca4d8-a27a-438b-a3de-8ebb8857740f",
                        "name": "Sugar",
                        "image": "https://www.thespruceeats.com/thmb/RlMPgkSpqsFGi0wDlJcwy4wYu2Y=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/demerarasugarOllo-1ace15d9396f4e22b5bd3f5867a818e6.jpg",
                        "quantity": "1 teaspoon",
                        "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                        "created_at": "2025-08-23T07:53:37.000000Z",
                        "updated_at": "2025-08-23T07:53:37.000000Z"
                      },
                      {
                        "ingredient_id": "867a2cc7-72cb-4741-a361-c31d8e5bf564",
                        "name": "Salt",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRaY7l33pRQSrOYXDvKsOIfUsHvlp154XzyA&s",
                        "quantity": "to taste",
                        "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                        "created_at": "2025-08-23T07:53:37.000000Z",
                        "updated_at": "2025-08-23T07:53:37.000000Z"
                      },
                      {
                        "ingredient_id": "93cb3d78-fcad-4288-8b11-07ecbb2788e2",
                        "name": "Vegetable Oil",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRn3_fiPyVLcTtgnXpxBYeUJPmk_aQjSDBcA&s",
                        "quantity": "1/4 cup (plus extra for frying)",
                        "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                        "created_at": "2025-08-23T07:53:37.000000Z",
                        "updated_at": "2025-08-23T07:53:37.000000Z"
                      },
                      {
                        "ingredient_id": "a9df9d5d-58e2-4dbf-bb9e-52336e48f3e5",
                        "name": "Water",
                        "image": "https://aussiegold.net.au/wp-content/uploads/2023/10/Pouring-a-fresh-and-clean-water-into-the-glass.jpg",
                        "quantity": "1 cup (warm)",
                        "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                        "created_at": "2025-08-23T07:53:37.000000Z",
                        "updated_at": "2025-08-23T07:53:37.000000Z"
                      },
                      {
                        "ingredient_id": "bb2e6067-4565-4e29-a2e8-149ff37cd2d9",
                        "name": "All-Purpose Flour",
                        "image": "https://greenspoon.co.ke/wp-content/uploads/2022/12/Greenspoon-Kenya-Ajab-Fortified-All-Purpose-Home-Baking-Flour-2kg.jpg",
                        "quantity": "3 cups(depends)",
                        "recipe_id": "2b37acf1-fdd5-4b70-9f7c-b39130148582",
                        "created_at": "2025-08-23T07:53:37.000000Z",
                        "updated_at": "2025-08-23T07:53:37.000000Z"
                      }
                    ]
                  },
                  {
                    "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                    "name": "Nyama Choma",
                    "description": "Nyama Choma is a delicious Kenyan goat meat delicacy you can enjoy any time of the day. It is nutritious, versatile, and oh-so finger-licking good!",
                    "image": "https://cdn.foodandmeal.com/wp-content/uploads/2023/10/3.1-1-3.jpg?strip=all&lossy=1&ssl=1",
                    "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "instructions": "1. Wash and drain the goat meat, then cut them into smaller bite sizes. 2.Pour your oil and spices into a mixing bowl and mix them. 3. Blend the onions and garlic coarsely in a food processor, or finely chop them if you prefer. 4. Put the chunks of meat into the mixing bowl, add the spices, the blended garlic, and onion, and properly mix everything. 5. Marinate it in the fridge for 2 hours or longer. I prefer to let it marinate overnight for even more flavor. 6. Bring it out of the refrigerator and let it come to room temperature. 7. Turn the grill to medium-low heat and arrange the meat on the grill. 8. Add 2 tablespoon of salt to 2 cups of water. Grill the meat for 50 minutes, turning every 10 minutes and basting with the salt water.",
                    "created_at": "2025-08-23T06:40:28.000000Z",
                    "updated_at": "2025-08-23T06:40:28.000000Z",
                    "ingredients_list": [
                      {
                        "ingredient_id": "01aebbf7-43f5-4bb7-88e8-faefadb2c29e",
                        "name": "Salt",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRaY7l33pRQSrOYXDvKsOIfUsHvlp154XzyA&s",
                        "quantity": "to taste",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      },
                      {
                        "ingredient_id": "43ec49f5-349d-4052-9e82-42a70d41d79a",
                        "name": "Rosemary (fresh or dried)",
                        "image": "https://cdn.mafrservices.com/sys-master-root/h2b/h1e/31009212596254/146405_main.jpg?im=Resize=480",
                        "quantity": "1 teaspoon, minced",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      },
                      {
                        "ingredient_id": "478bc0f2-1a98-4a68-854d-a73168012d82",
                        "name": "Curry Powder",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTItv5y9l5dcWD8ox-XLMrNSeapXgzo63aTw&s",
                        "quantity": "1 teaspoon",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      },
                      {
                        "ingredient_id": "8b31b267-d6ab-486f-b233-04461cc81156",
                        "name": "Goat Meat (Nyama Choma Classic)",
                        "image": "https://halalmeatnj.com/cdn/shop/files/00690085390334.jpg?v=1740430667",
                        "quantity": "1 Kg",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      },
                      {
                        "ingredient_id": "96a38099-e0f3-4016-b5bf-847c1e7ddda9",
                        "name": "Vegetable Oil",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRn3_fiPyVLcTtgnXpxBYeUJPmk_aQjSDBcA&s",
                        "quantity": "1/4 cup",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      },
                      {
                        "ingredient_id": "9d87c221-f6f8-4456-a690-01eeeb29e2d5",
                        "name": "Paprika",
                        "image": "https://freshgrain.net/wp-content/uploads/2023/11/PAPRIKA.png",
                        "quantity": "1 tablespoon",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      },
                      {
                        "ingredient_id": "cbcc3368-cb5e-45df-8a69-c3adc4baa848",
                        "name": "Bouillon Powder or Soy Sauce",
                        "image": "https://www.mapleandmango.com/wp-content/uploads/2021/09/bouillon-powder-feature.jpg",
                        "quantity": "1 teaspoon bouillon powder or 1 tablespoon soy sauce",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      },
                      {
                        "ingredient_id": "ccb5e7f2-bf1a-4cd2-87a4-15b27c5fe632",
                        "name": "Lemon Juice (freshly squeezed)",
                        "image": "https://lirp.cdn-website.com/7a5d8045/dms3rep/multi/opt/lemon+Juice-640w.webp",
                        "quantity": "1/4 cup",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      },
                      {
                        "ingredient_id": "e087ed34-da0b-4b5e-ac78-617bcd634572",
                        "name": "Black Pepper",
                        "image": "https://www.terraearthfood.com/cdn/shop/products/TerraBlackPepperPowder_1_d33b2385-e608-4b2c-830e-252c2de9773c_1024x1024.jpg?v=1626012511",
                        "quantity": "to taste",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      },
                      {
                        "ingredient_id": "e385aeb7-0789-4f88-8cc0-a4fe8750ed9f",
                        "name": "Garlic",
                        "image": "https://www.veggycation.com.au/siteassets/veggycationvegetable/garlic.jpg",
                        "quantity": "4 cloves, minced",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      },
                      {
                        "ingredient_id": "f2e48622-07ff-440d-965b-8eb4acaf270d",
                        "name": "Cayenne Pepper (optional)",
                        "image": "https://images.medicinenet.com/images/article/main_image/cayenne-pepper.jpg?output-quality=75",
                        "quantity": "1/4 teaspoon",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      },
                      {
                        "ingredient_id": "fe2eb683-bd87-4782-be3b-478bc8a0fd25",
                        "name": "Ginger",
                        "image": "https://www.vitaeinternational.com/wp-content/uploads/2015/12/benefits-of-ginger.jpg",
                        "quantity": "1 tablespoon, grated",
                        "recipe_id": "954097f8-a43a-4990-8372-64e0cd39c2ac",
                        "created_at": "2025-08-23T06:40:28.000000Z",
                        "updated_at": "2025-08-23T06:40:28.000000Z"
                      }
                    ]
                  },
                  {
                    "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                    "name": "Coq au Vin",
                    "description": "A traditional French dish made with chicken braised in red wine with mushrooms, onions, and herbs. Rich, comforting, and perfect for a family dinner.",
                    "image": "https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/k%2FPhoto%2FRecipes%2F2024-10-coq-au-vin%2Fcoq-au-vin-083-vertical",
                    "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "instructions": "1. Marinate chicken in wine with herbs overnight. 2. Fry bacon until crispy. Remove and set aside. 3. Brown chicken in the same pan. 4. Add onions, garlic, and mushrooms, cook until softened. 5. Pour in wine and simmer with thyme and bay leaves. 6. Cook for 1.5–2 hours until chicken is tender. 7. Serve hot with mashed potatoes or crusty bread.",
                    "created_at": "2025-08-23T08:14:59.000000Z",
                    "updated_at": "2025-08-23T08:14:59.000000Z",
                    "ingredients_list": [
                      {
                        "ingredient_id": "30cae55a-e01e-40d6-97b3-b03cab308ec7",
                        "name": "Garlic",
                        "image": "https://www.veggycation.com.au/siteassets/veggycationvegetable/garlic.jpg",
                        "quantity": "3 cloves, minced",
                        "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                        "created_at": "2025-08-23T08:14:59.000000Z",
                        "updated_at": "2025-08-23T08:14:59.000000Z"
                      },
                      {
                        "ingredient_id": "4e81d015-4999-4bf9-9899-74db207d1238",
                        "name": "Red Wine",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmp8tS9VMnXOMEV28gitwMd8QEE0Q0WwMxIw&s",
                        "quantity": "750 ml",
                        "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                        "created_at": "2025-08-23T08:14:59.000000Z",
                        "updated_at": "2025-08-23T08:14:59.000000Z"
                      },
                      {
                        "ingredient_id": "8e1703a1-baa2-4d64-ae13-e0ff321d2929",
                        "name": "Mushrooms",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5bqr81wEhkl16OiTz5PGo7asbwqWJffGxHw&s",
                        "quantity": "250 g, sliced",
                        "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                        "created_at": "2025-08-23T08:14:59.000000Z",
                        "updated_at": "2025-08-23T08:14:59.000000Z"
                      },
                      {
                        "ingredient_id": "95e55271-9d63-4fe7-95a2-91d2c1215216",
                        "name": "Bacon",
                        "image": "https://amazingribs.com/wp-content/uploads/2012/05/canadian-bacon.jpg",
                        "quantity": "150 g, diced",
                        "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                        "created_at": "2025-08-23T08:14:59.000000Z",
                        "updated_at": "2025-08-23T08:14:59.000000Z"
                      },
                      {
                        "ingredient_id": "a8f8050d-9ad3-42cd-b313-b0102d19a515",
                        "name": "Onions (small pearl onions)",
                        "image": "https://image.tuasaude.com/media/article/ru/ny/beneficios-da-cebola_39481.jpg?width=686&height=487",
                        "quantity": "200 g",
                        "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                        "created_at": "2025-08-23T08:14:59.000000Z",
                        "updated_at": "2025-08-23T08:14:59.000000Z"
                      },
                      {
                        "ingredient_id": "e697b552-eb1d-4d81-91e2-ea95a753b725",
                        "name": "Chicken (cut into pieces)",
                        "image": "https://www.eatthis.com/wp-content/uploads/sites/4/2022/12/whole-cooked-chicken.jpg?quality=82&strip=all",
                        "quantity": "1 whole (about 1.5 kg)",
                        "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                        "created_at": "2025-08-23T08:14:59.000000Z",
                        "updated_at": "2025-08-23T08:14:59.000000Z"
                      },
                      {
                        "ingredient_id": "f7ac1a4e-2062-41f4-ba58-e2ac0fc8fea0",
                        "name": "Thyme & Bay Leaves",
                        "image": "https://www.acquagarden.co.uk/cdn/shop/files/acquagarden-kitchen-bay-leaf-37888413630619.jpg?v=1725130914&width=900",
                        "quantity": "1 sprig thyme, 2 bay leaves",
                        "recipe_id": "9a413d23-c3bf-494f-a072-761980313466",
                        "created_at": "2025-08-23T08:14:59.000000Z",
                        "updated_at": "2025-08-23T08:14:59.000000Z"
                      }
                    ]
                  }
                ],
                "all_rates": [
                  {
                    "rate_id": "5a0ac4b0-7166-440a-bc2a-97c057f9923e",
                    "ratee_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "rater_id": "0Z2QSBXbfwRX9YOHTlCB3NfSZuF2",
                    "rating": 4,
                    "comment": "Good recipes",
                    "created_at": "2025-09-07T08:56:50.000000Z",
                    "updated_at": "2025-09-07T08:56:50.000000Z",
                    "rater": {
                      "user_id": "ec11a426-7f45-4a3a-89f7-d50e380792f7",
                      "name": "Martin Wainaina",
                      "email": "martinwainaina001@gmail.com",
                      "open_id": "0Z2QSBXbfwRX9YOHTlCB3NfSZuF2",
                      "avatar": "/images/profile/default.png",
                      "role": "Customer",
                      "gender": null,
                      "auth_type": "Email",
                      "date_of_birth": null,
                      "phone": null,
                      "phone_complete": null,
                      "country_code": null,
                      "token": "Daqat29rEUwimgJvtl42tJYu2FUAr64MveL1dA6kYK0IHDOpm7dyyLZ19JUOpBAhaBR8ypFOq2IbS5BiSOWLs4IStkXigFHsmI5be",
                      "access_token": "dHHz1ttNEEg3yR57YoWTELUsH756J2UBRYyrS80mzz8wyXlCRB7Y8x0FOxFdYParaTTPXIz9ZvTr2M53dUEHJXmf87sEYnpgLWKrt",
                      "created_at": "2025-08-22T10:50:49.000000Z",
                      "updated_at": "2026-08-21T05:39:24.000000Z"
                    }
                  },
                  {
                    "rate_id": "cdf315c6-07f6-4f54-a4d2-6425427b4477",
                    "ratee_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "rater_id": "0Z2QSBXbfwRX9YOHTlCB3NfSZuF2",
                    "rating": 5,
                    "comment": "Awesome reipe",
                    "created_at": "2025-08-24T18:38:29.000000Z",
                    "updated_at": "2025-08-24T18:38:29.000000Z",
                    "rater": {
                      "user_id": "ec11a426-7f45-4a3a-89f7-d50e380792f7",
                      "name": "Martin Wainaina",
                      "email": "martinwainaina001@gmail.com",
                      "open_id": "0Z2QSBXbfwRX9YOHTlCB3NfSZuF2",
                      "avatar": "/images/profile/default.png",
                      "role": "Customer",
                      "gender": null,
                      "auth_type": "Email",
                      "date_of_birth": null,
                      "phone": null,
                      "phone_complete": null,
                      "country_code": null,
                      "token": "Daqat29rEUwimgJvtl42tJYu2FUAr64MveL1dA6kYK0IHDOpm7dyyLZ19JUOpBAhaBR8ypFOq2IbS5BiSOWLs4IStkXigFHsmI5be",
                      "access_token": "dHHz1ttNEEg3yR57YoWTELUsH756J2UBRYyrS80mzz8wyXlCRB7Y8x0FOxFdYParaTTPXIz9ZvTr2M53dUEHJXmf87sEYnpgLWKrt",
                      "created_at": "2025-08-22T10:50:49.000000Z",
                      "updated_at": "2026-08-21T05:39:24.000000Z"
                    }
                  },
                  {
                    "rate_id": "d71e5fb4-2ce0-4948-95fd-33266745830e",
                    "ratee_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                    "rater_id": "0Z2QSBXbfwRX9YOHTlCB3NfSZuF2",
                    "rating": 4,
                    "comment": "Good Recipe",
                    "created_at": "2025-09-07T09:02:20.000000Z",
                    "updated_at": "2025-09-07T09:02:20.000000Z",
                    "rater": {
                      "user_id": "ec11a426-7f45-4a3a-89f7-d50e380792f7",
                      "name": "Martin Wainaina",
                      "email": "martinwainaina001@gmail.com",
                      "open_id": "0Z2QSBXbfwRX9YOHTlCB3NfSZuF2",
                      "avatar": "/images/profile/default.png",
                      "role": "Customer",
                      "gender": null,
                      "auth_type": "Email",
                      "date_of_birth": null,
                      "phone": null,
                      "phone_complete": null,
                      "country_code": null,
                      "token": "Daqat29rEUwimgJvtl42tJYu2FUAr64MveL1dA6kYK0IHDOpm7dyyLZ19JUOpBAhaBR8ypFOq2IbS5BiSOWLs4IStkXigFHsmI5be",
                      "access_token": "dHHz1ttNEEg3yR57YoWTELUsH756J2UBRYyrS80mzz8wyXlCRB7Y8x0FOxFdYParaTTPXIz9ZvTr2M53dUEHJXmf87sEYnpgLWKrt",
                      "created_at": "2025-08-22T10:50:49.000000Z",
                      "updated_at": "2026-08-21T05:39:24.000000Z"
                    }
                  }
                ],
                "rate": {
                  "rate_id": "86817d49-dde9-4e97-b993-196b430fb5fb",
                  "open_id": "2yAFSNPiekbcdhd0vsFhG0XgD1D3",
                  "rating": 4.333333333333333,
                  "total_ratings": 3,
                  "created_at": "2025-08-24T18:38:29.000000Z",
                  "updated_at": "2025-09-07T09:02:20.000000Z"
                }
              },
              {
                "user_id": "de00b711-11b7-44b0-9c92-0cbe7d1f0ad9",
                "name": "Safiri Chefs",
                "email": "safiribytes@gmail.com",
                "open_id": "yzuITvR4p1fYMn0tiC1yyalPogu1",
                "avatar": "/images/profile/chef_avatar.png",
                "role": "Chef",
                "gender": null,
                "auth_type": "Email",
                "date_of_birth": null,
                "phone": null,
                "phone_complete": null,
                "country_code": null,
                "token": "te3sh8selC1FBOoLrheBGFNJ9lIUypBu0iesndBJNmPlb6xhUipLwynO1ZtR0GSm4ppxUKKW4fnA7LSRuBDwUZKk4oZMOReJKi0gz",
                "access_token": "Y4lcaRkQnlebYkJtfNoMTl8LtOLuuqkgWIlzCB249EkcEo5NygVKRtWa9nXatpJaEmCjpMgiCdGzA1X5rHwIdxtQFJAiJ9fLKExvY",
                "created_at": "2025-08-23T08:29:07.000000Z",
                "updated_at": "2025-08-23T08:29:07.000000Z",
                "recipes_list": [
                  {
                    "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                    "name": "Ratatouille",
                    "description": "A vegetable medley from Provence made with eggplant, zucchini, bell peppers, tomatoes, and herbs. Healthy, colorful, and bursting with flavor.",
                    "image": "https://cookingorgeous.com/wp-content/uploads/2021/08/ratatouille-nicoise-30.jpg",
                    "open_id": "yzuITvR4p1fYMn0tiC1yyalPogu1",
                    "instructions": "1. Heat olive oil in a pan. 2. Sauté onions and garlic until soft. 3. Add eggplant, zucchini, and peppers, cook for 10 minutes. 4. Add tomatoes and herbs, simmer for 20 minutes. 5. Adjust seasoning with salt and pepper. 6. Serve hot with bread or as a side dish.",
                    "created_at": "2025-08-23T08:42:09.000000Z",
                    "updated_at": "2025-08-23T08:42:09.000000Z",
                    "ingredients_list": [
                      {
                        "ingredient_id": "0fdedac6-86d6-45f8-a5d9-6ca3f4adb4b8",
                        "name": "Olive Oil",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRn3_fiPyVLcTtgnXpxBYeUJPmk_aQjSDBcA&s",
                        "quantity": "4 tablespoons",
                        "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                        "created_at": "2025-08-23T08:42:09.000000Z",
                        "updated_at": "2025-08-23T08:42:09.000000Z"
                      },
                      {
                        "ingredient_id": "2941d897-489e-4814-8cab-749be90fe981",
                        "name": "Onion",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAQyyA1MHofXz2r1opzUjfDBKeutCoAmUNqQ&s",
                        "quantity": "1, chopped",
                        "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                        "created_at": "2025-08-23T08:42:09.000000Z",
                        "updated_at": "2025-08-23T08:42:09.000000Z"
                      },
                      {
                        "ingredient_id": "2c69e678-329d-4e72-8031-451b9d316078",
                        "name": "Bell Peppers (red & yellow)",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZVYa_RBlmhm9U4LPivanbeLe4aZ1PHG_JJQ&s",
                        "quantity": "2, sliced",
                        "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                        "created_at": "2025-08-23T08:42:09.000000Z",
                        "updated_at": "2025-08-23T08:42:09.000000Z"
                      },
                      {
                        "ingredient_id": "3aafc5f9-f76f-4523-855e-e0fa9f7f39b7",
                        "name": "Zucchini",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNZ2hJYtaYVZYq1AdkzdUAK3kPZ8hUjFkz7A&s",
                        "quantity": "2 medium, sliced",
                        "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                        "created_at": "2025-08-23T08:42:09.000000Z",
                        "updated_at": "2025-08-23T08:42:09.000000Z"
                      },
                      {
                        "ingredient_id": "5f23608c-638a-4c0c-8778-a2ce01af4f9b",
                        "name": "Tomatoes",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5B62fXmxWeGjDSdcvmGf3WP1QAb9Duqty2A&s",
                        "quantity": "4 large, chopped",
                        "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                        "created_at": "2025-08-23T08:42:09.000000Z",
                        "updated_at": "2025-08-23T08:42:09.000000Z"
                      },
                      {
                        "ingredient_id": "a3c851a4-06da-4735-b289-208ddd002839",
                        "name": "Eggplant",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7K5A41Y2QT8db6KbhiE8xrCzSQCNk_7egIA&s",
                        "quantity": "2 medium, diced",
                        "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                        "created_at": "2025-08-23T08:42:09.000000Z",
                        "updated_at": "2025-08-23T08:42:09.000000Z"
                      },
                      {
                        "ingredient_id": "de28654e-d7fb-4c3f-bc3d-998b91dfd264",
                        "name": "Herbs de Provence",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSB7nzI8PwbLVcPAUWmXyR05wemPsSABnpQ3A&s",
                        "quantity": "1 tablespoon",
                        "recipe_id": "03c6335c-57e6-45af-9ba2-df426ac3ccfd",
                        "created_at": "2025-08-23T08:42:09.000000Z",
                        "updated_at": "2025-08-23T08:42:09.000000Z"
                      }
                    ]
                  }
                ],
                "all_rates": [],
                "rate": null
              }
            ]
          }
        }
        """
}
