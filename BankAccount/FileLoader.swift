//
//  FileLoader.swift
//  BankAccount
//
//  Created by Goushik Kumar T on 14/12/23.
//

import Foundation

enum FileLoaderError: Error {
    case fileNotFound
}

class FileLoader {
    static func load<T: Decodable>(_ filename: String, as type: T.Type = T.self, completion: @escaping (Result<T, Error>) -> Void) {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let result = try decoder.decode(type, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(FileLoaderError.fileNotFound))
        }
    }
}
