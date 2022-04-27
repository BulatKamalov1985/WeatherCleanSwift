//
//  NetworkServiceProtocol.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 18.04.2022.
//

import Foundation

protocol EndpointTypeProtocol {
    var stringUrl: String { get }
}

protocol NetworkSessionProtocol {
    var session: URLSession { get set }
    func network<Success: Decodable>(
        endpoint: EndpointTypeProtocol,
        completion: @escaping (Result<Success, NetworkError>) -> Void
    )
}

extension EndpointTypeProtocol {
    var url: URL? {
        URL(string: stringUrl)
    }
}

extension NetworkSessionProtocol {
    func  network<Success: Decodable>(
        endpoint: EndpointTypeProtocol,
        completion: @escaping (Result<Success, NetworkError>) -> Void
    ) {
        guard let url = endpoint.url else {
            completion(.failure(.badRequest))
            print("completion failure network")
            return
        }
        let task = session.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let weather = try JSONDecoder().decode(Success.self, from: data)
                    completion(.success(weather))
                    print("good decode weather", weather.self)
                } catch {
                    completion(.failure(.decodeError))
                    print("no good")
                    return
                }
            } else {
                completion(.failure(.badRequest))
                print("completion failure network")
                return
            }
        }
        task.resume()
        print("task.resume", task)
    }
}

enum NetworkError: Error {
    case badRequest
    case errorJSON
    case srorageIsEmty
    case unknownError
    case decodeError
}
