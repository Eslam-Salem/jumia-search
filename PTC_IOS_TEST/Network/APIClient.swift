//
//  APIClient.swift
//
//  Created by Eslam Salem on 4/23/21.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}


enum APIClient {
    static func request<ResponseType: Decodable>(
        url: URL,
        httpMethod: HTTPMethod,
        responseType: ResponseType.Type,
        decoder: JSONDecoder,
        completion: @escaping (ResponseType?, Error?) -> Void
    ) {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        let task = session.dataTask(with: request) { data, response, error in
            var completionError: Error?
            var completionResponse: ResponseType?
            guard let data = data, error == nil else {
                completionError = error
                return
            }
            do {
                let decodedResponse = try decoder.decode(ResponseType.self, from: data)
                completionResponse = decodedResponse
            } catch let error {
                completionError = error
            }
            DispatchQueue.main.async {
                completion(completionResponse, completionError)
            }
        }
        task.resume()
    }
}
