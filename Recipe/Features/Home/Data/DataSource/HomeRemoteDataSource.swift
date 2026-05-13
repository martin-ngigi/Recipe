//
//  HomeRemoteDataSource.swift
//  Recipe
//
//  Created by Hummingbird on 29/06/2025.
//

import Foundation
import os

struct HomeRemoteDataSource {
    func fetchHomeData() async -> Result<HomeResponseModel, APIError> {
        guard let url = Constants.APIEndpoint.home.url else {
            return .failure(APIError.badURL)
        }

        let (responseData, response) = await NetworkUtils.shared.makeAPIRequest(
            url: url,
            httpMethod: .get
        )

        do {

            guard let data = responseData else {
                return .failure(APIError.unexpected)
            }

            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let httpResponse = response as? HTTPURLResponse, 400..<499 ~= httpResponse.statusCode {
                    guard let apiErrorMessage = json["message"] as? String else {
                        let errorMessage: String = json["message"] as? String ?? "Something went wrong!"
                        return .failure(APIError.custom(errorMessage))
                    }
                    return .failure(APIError.smthWentWrong)
                }
            }

            let decodedData = try JSONDecoder().decode(HomeResponseModel.self, from: data)
            return .success(decodedData)
        }
        catch let decodingError as DecodingError {
            os.Logger().debug("DEBUG: fetchHomeData decoding error \(decodingError)")
            return .failure(APIError.custom("We are unable to fetch home data, kindly try again."))
        }
        catch {
            return .failure(APIError.custom("We are unable to fetch home data, kindly try again."))
        }

    }

    func searchAll(searchTerm: String) async -> Result<SearchResponseModel, APIError> {
        guard let url = Constants.APIEndpoint.searchAll(searchTerm: searchTerm).url else {
            return .failure(APIError.badURL)
        }

        let (responseData, response) = await NetworkUtils.shared.makeAPIRequest(
            url: url,
            httpMethod: .get
        )

        do {

            guard let data = responseData else {
                return .failure(APIError.unexpected)
            }

            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let httpResponse = response as? HTTPURLResponse, 400..<499 ~= httpResponse.statusCode {
                    guard let apiErrorMessage = json["message"] as? String else {
                        let errorMessage: String = json["message"] as? String ?? "Something went wrong!"
                        return .failure(APIError.custom(errorMessage))
                    }
                    return .failure(APIError.unexpected)
                }
            }

            let decodedData = try JSONDecoder().decode(SearchResponseModel.self, from: data)
            return .success(decodedData)
        }
        catch let decodingError as DecodingError {
            os.Logger().debug("DEBUG: fetchHomeData decoding error \(decodingError)")
            return .failure(APIError.custom("We are unable to fulfil your search request, kindly try again."))
        }
        catch {
            return .failure(APIError.custom("We are unable to fulfil your search request, kindly try again."))
        }

    }
}
