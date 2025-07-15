//
//  AuthRemoteDataSource.swift
//  Recipe
//
//  Created by Hummingbird on 14/07/2025.
//

import Foundation

import Foundation

class AuthRemoteDataSource{
    @MainActor
    static let shared = AuthRemoteDataSource()

    func authenticateUser(user: UserModel) async -> Result<UserResponseModel, APIError>{
        guard let url = Constants.APIEndpoint.auth.url else {
            return .failure(APIError.badURL)
        }
        
        let (responseData, response) = await NetworkUtils.shared.makeAPIRequest(
            url: url,
            httpMethod: .POST,
            postData: user
        )
        
        do {
            
            guard let data = responseData else {
                return .failure(APIError.unexpected)
            }
            
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let httpResponse = response as? HTTPURLResponse, 400..<499 ~= httpResponse.statusCode {
                    guard  let apiErrorMessage = json["message"] as? String else {
                        let errorMessage: String = json["message"] as? String ?? "Something went wrong!"
                        return .failure(APIError.custom(errorMessage))
                    }
                    return .failure(APIError.unexpected)
                }
            }
            
            let decodedData = try JSONDecoder().decode(UserResponseModel.self, from: data)
            return .success(decodedData)
        }
        catch let decodingError as DecodingError {
            print("DEBUG: fetchHomeData decoding error \(decodingError)")
            return .failure(APIError.custom("We are unable to fetch home data, kindly try again."))
        } catch {
            return .failure(APIError.custom("We are unable to fetch home data, kindly try again."))
        }
    }
    
 
}
