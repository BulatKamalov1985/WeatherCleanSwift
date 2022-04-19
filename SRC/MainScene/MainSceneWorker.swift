//
//  MainSceneWorker.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainSceneWorker: MainSceneWorkerLogic, NetworkSessionProtocol {

    var session: URLSession

    init(
        session: URLSession = URLSession(configuration: .default)
    ) {
        self.session = session
    }

    func get(_ request: MainScene.InitForm.Request, completion: @escaping (Result<MainScene.InitForm.Response.CityWeather, NetworkError>) -> Void) {
        print("start func get")
        let endPoint: EndpointTypeProtocol = EndPoint(request: request)
        print("endPoint")
        let completionWrapper: (Result<MainScene.InitForm.Response.CityWeather, NetworkError>) -> Void = { result in
            print("switch result")
            switch result {
            case .success(let succes):
                completion(.success(succes))
                print("completion succes", succes)
            case .failure(_):
                completion(.failure(.badRequest))
                print("completion failure")
            }
        }
        network(endpoint: endPoint, completion: completionWrapper)
        print("start network")
    }
}

private struct EndPoint: EndpointTypeProtocol {

    let request: MainScene.InitForm.Request

    var stringUrl: String {
        "https://\(host)\(path)=\(body)&\(unitsMetric)&appid=\(keyAPI)"
    }

    private var host: String {
        "api.openweathermap.org/"
    }

    var path: String {
        "data/2.5/weather?q"
    }
    var unitsMetric: String {
        "units=metric"
    }
    var keyAPI: String {
        "cfb589760c9c0d83a8f525619f805670"
    }
    var body: String {
        switch request {
        case .cityWeather(let city):
            return city
        }
    }
}

