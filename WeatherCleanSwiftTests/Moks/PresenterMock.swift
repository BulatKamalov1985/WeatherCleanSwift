//
//  PresenterMock.swift
//  WeatherCleanSwiftTests
//
//  Created by Bulat Kamalov on 24.04.2022.
//

import Foundation
@testable import WeatherCleanSwift

final class PresenterMock: MainScenePresentationLogic {
    func presentInitForm(_ response: MainScene.InitForm.Response) {
    }

    func presentErrorAlertController() {
    }

    func presentStorageIsEmty() {
    }
}
