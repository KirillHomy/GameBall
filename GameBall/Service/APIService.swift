//
//  APIService.swift
//  GameBall
//
//  Created by Kirill Khomytsevych on 05.11.2023.
//

import Foundation

class APIService {
    static let shared = APIService()

    func fetchLinks(completion: @escaping (Result<LinksModel, Error>) -> Void) {
        guard let apiURL = URL(string: Constants.General.url) else { return }

        URLSession.shared.dataTask(with: apiURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let links = try JSONDecoder().decode(LinksModel.self, from: data)
                    completion(.success(links))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
