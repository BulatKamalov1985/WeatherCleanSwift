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
    let interactor = MainSceneInteractor()
}
