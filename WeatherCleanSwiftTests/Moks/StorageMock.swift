//
//  StorageMock.swift
//  WeatherCleanSwiftTests
//
//  Created by Bulat Kamalov on 21.04.2022.
//

import Foundation
@testable import WeatherCleanSwift
final class StorageMock: MainSceneStorageProtocol {
    var saveObjectTests = false
    var loadObjectTest = false
    var object: MainScene.CityWeather?
    var saveObject: [MainScene.CityWeather]?

    func saveObject(_ object: MainScene.CityWeather) {
        saveObjectTests = true
        self.object = object
    }
    func loadObject() -> [MainScene.CityWeather]? {
        loadObjectTest = true
        return saveObject
    }
}
