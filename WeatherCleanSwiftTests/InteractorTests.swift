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
        let request = MainScene.InitForm.Request(firstLoad: true, cityWeather: "Ufa")
        interactor.requestInitForm(request)
        XCTAssert(worker.getBaseWeatherWasCalled, "функция getBaseWeather должна быть вызывана, флаг TRUE")
    }
//    Проверяем на правильный город через замоканный result
    func testCheckingForCorrectCityInput() {
        let interactor = MainSceneInteractor(presenter: presenter, worker: worker)
        let request = MainScene.InitForm.Request(firstLoad: false, cityWeather: "Ufa")
        let expectation = XCTestExpectation(description: "wait city")
        interactor.requestInitForm(request)
        DispatchQueue.main.async {
            XCTAssert(self.presenter.presenterWasCalled, "Отправляем данные в презентер, флаг TRUE")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
//    Проверяем на вызов при неправильном вводе города
    func testCheckingForUnCorrectCityInput() {
        let interactor = MainSceneInteractor(presenter: presenter, worker: worker)
        let request = MainScene.InitForm.Request(firstLoad: false, cityWeather: "NoUfa")
        let expectation = XCTestExpectation(description: "wait city")
        interactor.requestInitForm(request)
        DispatchQueue.main.async {
            XCTAssert(self.presenter.errorAlertControllerWasCalled, "Вызываем alert, флаг TRUE")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
