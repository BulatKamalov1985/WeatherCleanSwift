//
//  MainSceneWorker.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainSceneWorker: MainSceneWorkerLogic, NetworkSessionProtocol {
    var storage: CitiesStorageProtocol
    var session: URLSession
    init(
        storage: CitiesStorageProtocol,
        session: URLSession = URLSession(configuration: .default)
    ) {
        self.session = session
        self.storage = storage
    }
    func getBaseWeather(
        _ request: MainScene.InitForm.Request,
        completion: @escaping (Result<[MainScene.CityWeather], NetworkError>) -> Void
    ) {
        if request.firstLoad,
           let response = storage.loadObject() {
            completion(.success(response))
            print("completion(.success(response))")
            return
        } else if request.firstLoad {
            completion(.failure(.srorageIsEmty))
            print("completion(.failure(.srorageIsEmty))")
            return
        } else {
            let endPoint: EndpointTypeProtocol = EndPoint(city: request.cityWeather ?? "")
            let completionWrapper: (Result<MainScene.CityWeather, NetworkError>) -> Void = { result in
                switch result {
                case .success(let success):
                    self.storage.saveObject(success)
                    completion(.success([success]))
                case .failure(_): completion(.failure(.badRequest))
                }
            }
            print("network")
            network(endpoint: endPoint, completion: completionWrapper)
        }
    }
    func getBaseWeatherFromUserDefaults(
        _ request: MainScene.InitForm.Request,
        completion: @escaping ([MainScene.CityWeather]
        ) -> Void
    ) {
        if let object = storage.loadObject() {
            completion(object)
        }
        return completion([])
    }
}
private struct EndPoint: EndpointTypeProtocol {
    let city: String
    var stringUrl: String {
        "https://\(host)\(path)=\(city)&\(unitsMetric)&appid=\(keyAPI)"
    }
    private var host: String {
        "api.openweathermap.org/"
    }
    private var path: String {
        "data/2.5/weather?q"
    }
    private var unitsMetric: String {
        "units=metric"
    }
    private var keyAPI: String {
        "cfb589760c9c0d83a8f525619f805670"
    }
}
