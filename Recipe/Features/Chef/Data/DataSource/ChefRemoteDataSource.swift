//
//  ChefRemoteDataSource.swift
//  Recipe
//
//  Created by Hummingbird on 06/07/2025.
//

import Foundation

struct ChefRemoteDataSource{
    func fetchChefById(chefId: String) async -> Result<ChefResponseModel, APIError> {
        guard let url = Constants.APIEdpoint.getChefById(chefId: chefId).url else {
            return .failure(APIError.badURL)
        }
        
        
        let (responseData, response) = await NetworkUtils.shared.makeAPIRequest(
            url: url,
            httpMethod: .GET
        )
        
        do {
            
            guard let data = responseData else {
                return .failure(APIError.unexpected)
            }
            
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let httpResponse = response as? HTTPURLResponse, 400..<499 ~= httpResponse.statusCode {
                    guard  let apiErrorMessage = json["message"] as? String else {
                        let errorMessage: String = json["message"] as? String ?? "Something went wrong while fetching chef data!"
                        return .failure(APIError.custom(errorMessage))
                    }
                    return .failure(APIError.unexpected)
                }
            }
            
            let decodedData = try JSONDecoder().decode(ChefResponseModel.self, from: data)
            return .success(decodedData)
        }
        catch let decodingError as DecodingError {
            print("DEBUG: fetchChefById decoding error \(decodingError)")
            return .failure(APIError.custom("We are unable to fetch chef data, kindly try again."))
        } catch {
            return .failure(APIError.custom("We are unable to fetch chef data, kindly try again."))
        }
        
    }
}
