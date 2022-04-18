//
//  MainScenePresenter.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class MainScenePresenter: MainScenePresentationLogic {
  
    weak var viewController: MainSceneDisplayLogic?

    func presentInitForm(_ response: ResponseModel) {
        let temp = Int(response.main.temp) - 273
        let feelsLike = Int(response.main.feelsLike) - 273
        let tempMin = Int(response.main.tempMin) - 273
        let tempMax = Int(response.main.tempMax) - 273
        let name = response.name
        let country = response.sys.country
        let pressure = response.main.pressure
        
        viewController?.displayInitForm(ViewModel(name: name, temp: temp, feelsLike: feelsLike, tempMin: tempMin, tempMax: tempMax, country: country, pressure: pressure))
    }
}
