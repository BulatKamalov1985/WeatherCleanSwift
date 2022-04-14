//
//  MainSceneModels.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

enum MainScene {
    enum InitForm {
        struct Request {
           
        }
        struct Response {
        
        }
        struct ViewModel {
            let location: String
            let realTime: String
            let currentTemperature: String
            let lowTemperature: String
            let highTemperature: String
            let description: String
        }
    }
}
