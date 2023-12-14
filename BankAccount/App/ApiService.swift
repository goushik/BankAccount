//
//  ApiService.swift
//  BankAccount
//
//  Created by Goushik Kumar T on 14/12/23.
//

import Foundation

enum APIServiceError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidData
}

class APIService {
    static let shared = APIService()

    private init() {}

    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.requestFailed(APIServiceError.invalidData)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }
}
