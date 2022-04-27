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
    let presenter = MainScenePresenter()
    let viewController = ViewControllerMock()

    func testDisplayInitFormIsCalled() {
        presenter.viewController = viewController
        let response = MainScene.InitForm.Response(cityWeather: [])
        presenter.presentInitForm(response)
        XCTAssertTrue(viewController.displayInitFormIsCalled, "Функция displayInitForm должна быть вызвана")
    }

    func testErrorAlertControllerIsCalled() {
        presenter.viewController = viewController
        presenter.presentErrorAlertController()
        XCTAssertTrue(
            viewController.errorAlertControllerIsCalled, "Функция presentErrorAlertController() должна быть вызвана"
        )
    }

    func testStorageIsEmptyisCalled() {
        presenter.viewController = viewController
        presenter.presentStorageIsEmty()
        XCTAssertTrue(
            viewController.displayStorageIsEmptyisCalled, "Функция presentErrorAlertController() должна быть вызвана"
        )
    }
}
