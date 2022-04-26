//
//  PresenterTests.swift
//  WeatherCleanSwiftTests
//
//  Created by Bulat Kamalov on 21.04.2022.
//

import Foundation
import XCTest
@testable import WeatherCleanSwift

final class PresenterTests: XCTestCase {
    func testDisplayInitFormIsCalled() {
        let cityWeather = [MainScene.CityWeather]()
        let presenter = MainScenePresenter()
        let viewController = ViewControllerMock()
        presenter.viewController = viewController
        let response = MainScene.InitForm.Response(cityWeather: cityWeather)
        presenter.presentInitForm(response)
        XCTAssertTrue(viewController.displayInitFormIsCalled, "Функция displayInitForm должна быть вызвана")
    }

    func testErrorAlertControllerIsCalled() {
        let presenter = MainScenePresenter()
        let viewController = ViewControllerMock()
        presenter.viewController = viewController
        presenter.presentErrorAlertController()
        XCTAssertTrue(
            viewController.errorAlertControllerIsCalled, "Функция presentErrorAlertController() должна быть вызвана"
        )
    }

    func testStorageIsEmptyisCalled() {
        let presenter = MainScenePresenter()
        let viewController = ViewControllerMock()
        presenter.viewController = viewController
        presenter.presentStorageIsEmty()
        XCTAssertTrue(
            viewController.displayStorageIsEmptyisCalled, "Функция presentErrorAlertController() должна быть вызвана"
        )
    }
}
