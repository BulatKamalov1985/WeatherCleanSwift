//
//  InteractorTests.swift
//  WeatherCleanSwiftTests
//
//  Created by Bulat Kamalov on 24.04.2022.
//

import Foundation
import XCTest
@testable import WeatherCleanSwift

final class InteractorTests: XCTestCase {
    let presenter = PresenterMock()
    let worker = WorkerMock()
    func testGetBaseWeatherWasCalled() {
        let interactor = MainSceneInteractor(presenter: presenter, worker: worker)
        let request = MainScene.InitForm.Request(firstLoad: true)
        interactor.requestInitForm(request)
        XCTAssert(worker.getBaseWeatherWasCalled, "функция getBaseWeather должна быть вызывана, флаг TRUE")
    }
///    Проверяем на правильный город через замоканный result
    func testCheckingForCorrectCityInput() {
        let citiesArray = Array(repeating: mockWeather(), count: 2)
        worker.result = .success(citiesArray)
        let interactor = MainSceneInteractor(presenter: presenter, worker: worker)
        let request = MainScene.InitForm.Request(firstLoad: false)
        let expectation = XCTestExpectation(description: "wait city")
        interactor.requestInitForm(request)
        DispatchQueue.main.async {
            XCTAssert(self.presenter.presentInitFormWasCalled, "Отправляем данные в презентер, флаг TRUE")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
///  Проверяем на вызов метода presentStorageIsEmty
    func testCheckingForErrorJSON() {
        worker.result = .failure(.srorageIsEmty)
        let interactor = MainSceneInteractor(presenter: presenter, worker: worker)
        let request = MainScene.InitForm.Request(firstLoad: false)
        let expectation = XCTestExpectation(description: "wait city")
        interactor.requestInitForm(request)
        DispatchQueue.main.async {
            XCTAssert(self.presenter.storageIsEmptyWasCalled, "Вызываем alert, флаг TRUE")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    ///  Проверяем на вызов метода presentErrorAlertControlle
    func testCheckingForStorageIsEmpty() {
        worker.result = .failure(.errorJSON)
        let interactor = MainSceneInteractor(presenter: presenter, worker: worker)
        let request = MainScene.InitForm.Request(firstLoad: false)
        let expectation = XCTestExpectation(description: "wait city")
        interactor.requestInitForm(request)
        DispatchQueue.main.async {
            XCTAssert(self.presenter.errorAlertControllerWasCalled, "Вызываем alert, флаг TRUE")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}

private func mockWeather() -> MainScene.CityWeather {
    let main = MainScene.Main(temp: 22, feelsLike: 11, tempMin: 22, tempMax: 33, pressure: 33)
    let sys = MainScene.Sys(type: 22, id: 1, country: "Ru", sunrise: 1, sunset: 1)
    return .init(main: main, name: "Ufa", sys: sys)
}
