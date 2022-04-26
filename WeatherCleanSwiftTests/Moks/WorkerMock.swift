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
    var getBaseWeatherWasCalled = false
    func getBaseWeather(
        _ request: MainScene.InitForm.Request,
        completion: @escaping (Result<[MainScene.CityWeather], NetworkError>) -> Void
    ) {
        let resultArray = Array(repeating: mockWeather(), count: 2)
        let resultMock = Result<[MainScene.CityWeather], NetworkError>.success(resultArray)
        let errorStorageIsEmpty = Result<[MainScene.CityWeather], NetworkError>.failure(.srorageIsEmty)
        let diffeerentError = Result<[MainScene.CityWeather], NetworkError>.failure(.errorJSON)
        getBaseWeatherWasCalled = true
        if request.cityWeather == "Ufa" {
            completion(resultMock)
        } else {
            completion(diffeerentError)
        }
    }
    var session: URLSession
    init(
        session: URLSession = URLSession(configuration: .default)
    ) {
        self.session = session
    }
}

private func mockWeather() -> MainScene.CityWeather {
    let main = MainScene.Main(temp: 22, feelsLike: 11, tempMin: 22, tempMax: 33, pressure: 33)
    let sys = MainScene.Sys(type: 22, id: 1, country: "Ru", sunrise: 1, sunset: 1)
    return .init(main: main, name: "Ufa", sys: sys)
}
