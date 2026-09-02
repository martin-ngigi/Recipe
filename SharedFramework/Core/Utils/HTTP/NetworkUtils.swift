/*
* Created by Martin Wainaina on 31/08/2026
*
* Feel free to contribute.
*/

//
//  NetworkUtils.swift
//  Recipe
//
//  Created by Hummingbird on 08/06/2025.
//

import Foundation
import SwiftUI
import os

class NetworkUtils {
    static let shared = NetworkUtils()

    func makeAPIRequest(
        url: URL,
        httpMethod: HttpMethod,
        postData: Any? = nil,
        isSecureRequest: Bool = true
    ) async -> (Data?, URLResponse?) {
        
        let maxAttempts = 3
        var attempts = 0
        
        while attempts < maxAttempts {
            attempts += 1
            
            do {
                var request = URLRequest(url: url)
                request.httpMethod = httpMethod.getMethod
                request.cachePolicy = .reloadIgnoringLocalCacheData
                request.timeoutInterval = Constants.timeoutInterval
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                constructHeaders(request: &request, isSecureRequest: isSecureRequest)
                try constructBody(request: &request, postData: postData)
                
                let (data, response) = try await URLSession.shared.data(for: request)
                
                logRequestAndResponse(url: url, request: request, data: data)
                
                return (data, response)
            }
            catch {
                let errorMessage = error.localizedDescription.lowercased()
                
                os.Logger().debug("DEBUG: API ERROR: \(error.localizedDescription)")
                os.Logger().debug("DEBUG: Attempt: \(attempts)/\(maxAttempts)")
                
                // Network connection was lost.
                if errorMessage.contains("network connection was lost") {
                    os.Logger().debug("DEBUG: Network connection was lost.")
                    return (nil, nil)
                }
                
                // Request timed out.
                if errorMessage.contains("the request timed out") {
                    if attempts < maxAttempts {
                        os.Logger().debug("DEBUG: Request timed out. Retrying... \(attempts)/\(maxAttempts)")
                        continue
                    }
                    
                    // Third timeout.
                    os.Logger().debug("DEBUG: Request timed out after \(maxAttempts) attempts.")
                    return (nil, nil)
                }
                
                // Any other error should not be retried.
                return (nil, nil)
            }
        }
        
        // Safety fallback. Normally unreachable.
        return (nil, nil)
    }

    private func constructHeaders(request: inout URLRequest, isSecureRequest: Bool) {
        let accessToken = Constants.accessToken
        let deviceID = Constants.deviceId

        if isSecureRequest {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        request.addValue(deviceID, forHTTPHeaderField: "device_id")
    }

    private func constructBody(request: inout URLRequest, postData: Any?) throws {
        guard let postData = postData else { return }

        if let dictData = postData as? [String: Any] {
            // construct json data — serialize dictionary
            request.httpBody = try JSONSerialization.data(withJSONObject: dictData, options: [])
        }
        else if let codableData = postData as? Encodable {
            // construct model data — encode Codable model
            request.httpBody = try JSONEncoder().encode(AnyEncodable(codableData))
        }
        else {
            request.httpBody = Data()
        }
    }

    private func logRequestAndResponse(url: URL, request: URLRequest, data: Data) {
        let separator = String(repeating: "-", count: 110)
        let prettyHeaders =
            request.allHTTPHeaderFields?
            .map { "\($0.key): \($0.value)" }
            .joined(separator: "\n") ?? "No Headers"
        let method = request.httpMethod ?? "UNKNOWN"
        let requestPrettyBody = Utils.shared.formatPrettyJSON(data: request.httpBody)
        let responsePrettyBody = Utils.shared.formatPrettyJSON(data: data)

        os.Logger().debug("DEBUG: \(separator)")
        os.Logger().debug("DEBUG: \(method) URL: \(url)")
        os.Logger().debug("DEBUG: HEADERS: \n \(prettyHeaders)")
        os.Logger().debug("DEBUG: REQUEST: \n \(requestPrettyBody)")
        os.Logger().debug("DEBUG: RESPONSE:  \n\(responsePrettyBody)")
        os.Logger().debug("DEBUG: \n \(separator)")
    }

    deinit {}
}
