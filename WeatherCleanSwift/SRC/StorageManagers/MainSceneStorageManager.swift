//
//  MainSceneStorageManager.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 19.04.2022.
//

import Foundation

class MainSceneStorage: CitiesStorageProtocol {
    private let key = "weather"
    private let userDefoultManager: UserDefaults
    init(userDefoultManager: UserDefaults = .standard) {
        self.userDefoultManager = userDefoultManager
    }
    func saveObject(_ object: MainScene.CityWeather) {
        let data: Data?
        if var loadObject = loadObject() {
            loadObject.append(object)
            data = try? JSONEncoder().encode(loadObject)
        } else {
            data = try? JSONEncoder().encode([object])
        }
        guard let data = data else { return }
        userDefoultManager.set(data, forKey: key)
    }
        func loadObject() -> [MainScene.CityWeather]? {
        guard let data = userDefoultManager.value(forKey: key) as? Data else { return nil }
        let weather = try? JSONDecoder().decode([MainScene.CityWeather].self, from: data)
        return weather
    }
}
