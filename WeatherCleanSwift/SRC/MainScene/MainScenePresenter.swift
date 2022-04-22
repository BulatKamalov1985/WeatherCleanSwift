//
//  MainScenePresenter.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class MainScenePresenter: MainScenePresentationLogic {
    weak var viewController: MainSceneDisplayLogic?

    func presentErrorAlertController() {
        viewController?.errorAlertController()
    }

    func presentStorageIsEmty() {
        viewController?.displayStorageIsEmpty()
    }

    func presentInitForm(_ response: MainScene.InitForm.Response) {
        let weatherModel: [MainScene.CityWeather] = response.cityWeather
        let viewModel = MainScene.InitForm.ViewModel(cityWeather: weatherModel)
        viewController?.displayInitForm(viewModel)
    }
}
