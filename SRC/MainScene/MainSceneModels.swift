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
        enum Request {
            case cityWeather(String)
        }

        struct Response: Decodable {
            // MARK: - CityWeather
            let cityWeather: CityWeather
        }
        struct ViewModel {
            let name: String
            let temp: Int
            let feelsLike: Int
            let tempMin: Int
            let tempMax: Int
            let country: String
            let pressure: Int
            init(
                name: String,
                temp: Int,
                feelsLike: Int,
                tempMin: Int,
                tempMax: Int,
                country: String,
                pressure: Int
            ) {
                self.name = name
                self.temp = temp
                self.feelsLike = feelsLike
                self.tempMin = tempMin
                self.tempMax = tempMax
                self.country = country
                self.pressure = pressure
            }
        }
    }

    struct CityWeather: Decodable {
        let main: Main
        let name: String
        let sys: Sys
    }

    // MARK: - Main
    struct Main: Decodable {
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

    struct Sys: Decodable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}
