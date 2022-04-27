//
//  WorkerMock.swift
//  WeatherCleanSwiftTests
//
//  Created by Bulat Kamalov on 24.04.2022.
//

import Foundation
import XCTest
@testable import WeatherCleanSwift

class WorkerMock: MainSceneWorkerLogic, NetworkSessionProtocol {
    var result: Result<[MainScene.CityWeather], NetworkError>?
    var requestModel: MainScene.InitForm.Request?
    var getBaseWeatherWasCalled = false
    func getBaseWeather(
        _ request: MainScene.InitForm.Request,
        completion: @escaping (Result<[MainScene.CityWeather], NetworkError>) -> Void
    ) {
        requestModel = request
        getBaseWeatherWasCalled = true
        guard let result = result
        else {
            completion(.failure(.unknownError))
            return
        }
        completion(result)
    }

    var session: URLSession
    init(
        session: URLSession = URLSession(configuration: .default)
    ) {
        self.session = session
    }
}
