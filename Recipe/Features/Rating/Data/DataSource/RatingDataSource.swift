//
//  RatingDataSource.swift
//  Recipe
//
//  Created by Hummingbird on 26/07/2025.
//

import Foundation

struct RatingDataSource{
    func createUpdateRate(createRateRequestModel: CreateRateRequestModel) async -> Result<CreateRateResponseModel, APIError> {
        guard let url = Constants.APIEndpoint.createUpdateRate.url else {
            return .failure(APIError.badURL)
        }
        
        let (responseData, response) = await NetworkUtils.shared.makeAPIRequest(
            url: url,
            httpMethod: .POST,
            postData: createRateRequestModel
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
            
            let decodedData = try JSONDecoder().decode(CreateRateResponseModel.self, from: data)
            return .success(decodedData)
        }
        catch let decodingError as DecodingError {
            return .failure(APIError.custom("We are unable to submit rate, kindly try again later."))
        } catch {
            return .failure(APIError.custom("We are unable to submit rate, kindly try again later."))
        }
    }
}
