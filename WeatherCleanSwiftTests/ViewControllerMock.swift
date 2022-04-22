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
    func displayInitForm(_ viewModel: MainScene.InitForm.ViewModel) {
        displayInitFormIsCalled = true
    }
        var errorAlertControllerIsCalled = false
    func errorAlertController() {
        errorAlertControllerIsCalled = true
    }

    var displayStorageIsEmptyisCalled = false
    func displayStorageIsEmpty() {
        displayStorageIsEmptyisCalled = true
    }
}
