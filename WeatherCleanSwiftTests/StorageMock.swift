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
    func saveObject(_ object: MainScene.CityWeather) {
        saveObjectTests = true
    }
    var loadObjectTest = false
    func loadObject() -> [MainScene.CityWeather]? {
        let object = ([MainScene.CityWeather])()
        loadObjectTest = true
        return object
    }
}
