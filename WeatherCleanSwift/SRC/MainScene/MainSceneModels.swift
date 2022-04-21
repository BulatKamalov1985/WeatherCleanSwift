//
//  MainSceneModels.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum MainScene {
    enum InitForm {
        struct Request {
            var cityWeather: String?
            let firstLoad: Bool
            init(
                firstLoad: Bool,
                cityWeather: String? = nil
            ) {
                self.firstLoad = firstLoad
                self.cityWeather = cityWeather
            }
        }
        struct Response: Codable {
            // MARK: - CityWeather
            let cityWeather: [CityWeather]
        }
        struct ViewModel {
            var cityWeather: [CityWeather]
        }
    }
    struct CityWeather: Codable {
        let main: Main
        let name: String
        let sys: Sys
    }
    // MARK: - Main
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
        }
    }
    struct Sys: Codable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}
