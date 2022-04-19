//
//  MainSceneProtocols.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol MainSceneDataPassing {
    var dataStore: MainSceneDataStore { get }
}

protocol MainSceneDataStore {}

protocol MainSceneBusinessLogic {
    func requestInitForm(_ request: MainScene.InitForm.Request)
}

protocol MainSceneWorkerLogic {
    func get(_ request: MainScene.InitForm.Request, completion: @escaping (
        Result<MainScene.CityWeather, NetworkError>
    ) -> Void)
}

protocol MainScenePresentationLogic {
    func presentInitForm(_ response: MainScene.CityWeather)
    func presentErrorAlertController()
}

protocol MainSceneDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: MainScene.InitForm.ViewModel)
    func errorAlertController()
}

protocol MainSceneRoutingLogic {}
