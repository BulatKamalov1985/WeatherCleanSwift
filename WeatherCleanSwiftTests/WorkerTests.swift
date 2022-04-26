//
//  WorkerTests.swift
//  WeatherCleanSwiftTests
//
//  Created by Bulat Kamalov on 21.04.2022.
//

import Foundation
import XCTest
@testable import WeatherCleanSwift

final class WorekerTests: XCTestCase {
    ///    Проверка на певый вход и загрузку из стораджа
    func testSaveObject() {
        let storage = StorageMock()
        let worker = MainSceneWorker(storage: storage)
        let request = MainScene.InitForm.Request(firstLoad: true)
        worker.getBaseWeather(request, completion: { _ in })
        XCTAssert(storage.loadObjectTest, "функция loadObject должна быть вызывана флаг TRUE")
    }
    ///    Проверка на пустой сторадж
    func testIfSrorageIsEmty() {
        let storage = StorageMock()
        let worker = MainSceneWorker(storage: storage)
        let request = MainScene.InitForm.Request(firstLoad: true)
        worker.getBaseWeather(request, completion: { result in
            switch result {
            case .success:
                XCTFail("Fail")
            case .failure(let error):
                XCTAssert(error == .srorageIsEmty, "Должна быть ошибка, что stotage пустой")
            }
        })
        XCTAssert(storage.loadObjectTest, "функция loadObject должна быть вызывана флаг TRUE")
    }
    /// Проверка на декодинг и сохранение в сторадж
    func testDecodeSuccess() {
        let storageMock = StorageMock()
        let JSONSuccess = jsonMockSucces
        let sessionMock = UrlSessionMock(data: JSONSuccess, urlResponse: nil, error: nil)
        let worker = MainSceneWorker(storage: storageMock, session: sessionMock)
        let request = MainScene.InitForm.Request(firstLoad: false)
        let expectation = expectation(description: "\(#function)\(#line)")
        let object = mockWeather()
        storageMock.object = object
        worker.getBaseWeather(request) { result in
            switch result {
            case .success(let response):
                XCTAssert(response[0].name == "Ufa", "Результат должен быть равным Ufa")
                XCTAssert(storageMock.object?.name == response[0].name)
            case .failure:
                XCTFail("Fail")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    ///    Проверка на ошибку в JSON
    func testDecodeFailure() {
        let storageMock = StorageMock()
        let sessionMock = UrlSessionMock(data: jsonMockFailure, urlResponse: nil, error: nil)
        let worker = MainSceneWorker(storage: storageMock, session: sessionMock)
        let request = MainScene.InitForm.Request(firstLoad: false)
        sessionMock.data = jsonMockFailure
        let expectation1 = expectation(description: "\(#function)\(#line)")
        worker.getBaseWeather(request, completion: { result in
            switch result {
            case .success:
                XCTFail("Fail")
            case .failure(let error):
                XCTAssert(error == .errorJSON, "Должна быть ошибка в парсинге JSON")
            }
            expectation1.fulfill()
        })
        wait(for: [expectation1], timeout: 1)
    }
    ///   Проверка на правильность ввода города
    func testsUnknownCity() {
        let sessionMock = UrlSessionMock(data: jsonMockSucces, urlResponse: nil, error: nil)
        let request = MainScene.InitForm.Request(firstLoad: false, cityWeather: "gvjh")
        let storage = StorageMock()
        let worker = MainSceneWorker(storage: storage, session: sessionMock)
        let addErrorAllerExpection = XCTestExpectation(description: "Ждем Alert")
        worker.getBaseWeather(request) { result in
            switch result {
            case .success(let response):
                XCTAssertFalse(request.cityWeather == response[0].name, "Результат должен быть равным Ufa")
            case .failure:
                XCTFail("Fail")
            }
            addErrorAllerExpection.fulfill()
        }
        wait(for: [addErrorAllerExpection], timeout: 1)
    }
}

private func mockWeather() -> MainScene.CityWeather {
    let main = MainScene.Main(temp: 22, feelsLike: 11, tempMin: 22, tempMax: 33, pressure: 33)
    let sys = MainScene.Sys(type: 22, id: 1, country: "Ru", sunrise: 1, sunset: 1)
    return .init(main: main, name: "Ufa", sys: sys)
}

private class UrlSessionMock: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    var mockTask: MockTask
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        mockTask = MockTask(data: data, urlResponse: urlResponse, error: error)
    }
    override func dataTask(
        with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        mockTask.completionHandler = completionHandler
        return mockTask
    }
}

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let _error: Error?
    override var error: Error? {
        return _error
    }
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)!
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self._error = error
    }
    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler(self.data, self.urlResponse, self.error)
        }
    }
}

private var jsonMockFailure: Data? = {
    var json = """
                    {
                      "status": "OK",
                      "content": {
                        "deviceId": "123"
                      }
                    }
                    """
    return json.data(using: .utf8)
}()

private var jsonMockSucces: Data? = {
    var json = """
                    {
                    "coord": {
                    "lon": 56.0375,
                    "lat": 54.775
                    },
                    "weather": [
                    {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                    }
                    ],
                    "base": "stations",
                    "main": {
                    "temp": 9.61,
                    "feels_like": 7.79,
                    "temp_min": 9.61,
                    "temp_max": 9.65,
                    "pressure": 1020,
                    "humidity": 48,
                    "sea_level": 1020,
                    "grnd_level": 998
                    },
                    "visibility": 10000,
                    "wind": {
                    "speed": 3.46,
                    "deg": 12,
                    "gust": 6.28
                    },
                    "clouds": {
                    "all": 0
                    },
                    "dt": 1650640733,
                    "sys": {
                    "type": 2,
                    "id": 146105,
                    "country": "RU",
                    "sunrise": 1650589028,
                    "sunset": 1650641479
                    },
                    "timezone": 18000,
                    "id": 479561,
                    "name": "Ufa",
                    "cod": 200
                    }
                    """
    return json.data(using: .utf8)
}()
