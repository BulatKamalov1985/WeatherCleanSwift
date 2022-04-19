//
//  MainScenePresenter.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class MainScenePresenter: MainScenePresentationLogic {

    func presentErrorAlertController() {
        viewController?.errorAlertController()
    }

    weak var viewController: MainSceneDisplayLogic?

    func presentInitForm(_ response: MainScene.InitForm.Response.CityWeather) {

        viewController?.displayInitForm(MainScene.InitForm.ViewModel(
            name: response.name,
            temp: Int(response.main.temp),
            feelsLike: Int(response.main.feelsLike),
            tempMin: Int(response.main.tempMin),
            tempMax: Int(response.main.tempMax),
            country: response.sys.country,
            pressure: response.main.pressure
        ))
    }
}
