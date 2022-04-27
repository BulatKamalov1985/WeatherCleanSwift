//
//  PresenterMock.swift
//  WeatherCleanSwiftTests
//
//  Created by Bulat Kamalov on 24.04.2022.
//

import Foundation
@testable import WeatherCleanSwift

final class PresenterMock: MainScenePresentationLogic {
    var presentInitFormWasCalled = false
    var errorAlertControllerWasCalled = false
    var storageIsEmptyWasCalled = false
    func presentInitForm(_ response: MainScene.InitForm.Response) {
        presentInitFormWasCalled = true
    }

    func presentErrorAlertController() {
        errorAlertControllerWasCalled = true
    }

    func presentStorageIsEmty() {
        storageIsEmptyWasCalled = true
    }
}
