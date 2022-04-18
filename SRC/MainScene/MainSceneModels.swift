//
//  MainSceneModels.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation
import UIKit

typealias ViewModel = MainScene.InitForm.ViewModel
typealias RequestModel = MainScene.InitForm.Request
typealias ResponseModel = MainScene.InitForm.Response.CityWeather

enum MainScene {
    enum InitForm {
        enum Request {
            case cityWeather(String)
        }
        
        struct Response: Decodable {
            
            // MARK: - CityWeather
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
        
        struct ViewModel {
            let name: String
            let temp: Int
            let feelsLike: Int
            let tempMin: Int
            let tempMax: Int
            let country: String
            let pressure: Int
        }
    }
}

