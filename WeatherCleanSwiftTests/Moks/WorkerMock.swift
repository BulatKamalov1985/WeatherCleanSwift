//
//  WorkerMock.swift
//  WeatherCleanSwiftTests
//
//  Created by Bulat Kamalov on 24.04.2022.
//

import Foundation
@testable import WeatherCleanSwift

class WorkerMock: MainSceneWorkerLogic, NetworkSessionProtocol {
    func getBaseWeather(
        _ request: MainScene.InitForm.Request,
        completion: @escaping (Result<[MainScene.CityWeather], NetworkError>) -> Void
    ) {
    }

    var session: URLSession
    init(
        session: URLSession = URLSession(configuration: .default)
    ) {
        self.session = session
    }
}
