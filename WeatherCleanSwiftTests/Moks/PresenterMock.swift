//
//  PresenterMock.swift
//  WeatherCleanSwiftTests
//
//  Created by Bulat Kamalov on 24.04.2022.
//

import Foundation
@testable import WeatherCleanSwift

final class PresenterMock: MainScenePresentationLogic {
    var presenterWasCalled = false
    var errorAlertControllerWasCalled = false
    var storageIsEmptyWasCalled = false
    func presentInitForm(_ response: MainScene.InitForm.Response) {
        presenterWasCalled = true
    }

    func presentErrorAlertController() {
        errorAlertControllerWasCalled = true
    }

    func presentStorageIsEmty() {
        storageIsEmptyWasCalled = true
    }
}
