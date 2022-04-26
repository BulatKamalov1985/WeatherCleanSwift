//
//  ViewControllerMock.swift
//  WeatherCleanSwiftTests
//
//  Created by Bulat Kamalov on 21.04.2022.
//

import Foundation
@testable import WeatherCleanSwift
final class ViewControllerMock: MainSceneDisplayLogic {
    var displayInitFormIsCalled = false
    var errorAlertControllerIsCalled = false
    var displayStorageIsEmptyisCalled = false

    func displayInitForm(_ viewModel: MainScene.InitForm.ViewModel) {
        displayInitFormIsCalled = true
    }

    func errorAlertController() {
        errorAlertControllerIsCalled = true
    }

    func displayStorageIsEmpty() {
        displayStorageIsEmptyisCalled = true
    }
}
