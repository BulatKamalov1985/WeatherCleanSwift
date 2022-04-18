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
    
    func get(_ request: RequestModel, completion: @escaping (Result<ResponseModel, NetworkError>) -> Void) {
        print("start func get")
        let endPoint: EndpointTypeProtocol = EndPoint(request: request)
        print("endPoint")
        let completionWrapper: (Result<ResponseModel, NetworkError>) -> Void = { result in
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

private struct EndPoint : EndpointTypeProtocol {
    
  
    let request: RequestModel
    
    var stringUrl: String {
        scheme + host + path
    }
    
    private var scheme: String {
        "https://"
    }
    
    private var host: String {
        "api.openweathermap.org/"
    }
    
    var path: String {
        "data/2.5/weather?q=\(body)&appid=cfb589760c9c0d83a8f525619f805670"
    }
    
    var body: String {
        switch request {
        case .cityWeather(let city):
            return city
        }
    }
}

    
    
