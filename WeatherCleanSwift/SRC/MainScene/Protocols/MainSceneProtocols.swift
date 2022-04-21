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
    func getBaseWeatherFromUserDefaults(
    _ request: MainScene.InitForm.Request,
    completion: @escaping ([MainScene.CityWeather]) -> Void
    )
    func getBaseWeather(
        _ request: MainScene.InitForm.Request,
        completion: @escaping (Result<[MainScene.CityWeather], NetworkError>) -> Void
    )
}

protocol MainScenePresentationLogic {
    func presentInitForm(_ response: MainScene.InitForm.Response)
    func presentErrorAlertController()
    func presentStorageIsEmty()
}

protocol MainSceneDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: MainScene.InitForm.ViewModel)
    func errorAlertController()
    func displayStorageIsEmpty()
}

protocol MainSceneRoutingLogic {}

protocol CitiesStorageProtocol {
    func saveObject(_ object: MainScene.CityWeather)
    func loadObject() -> [MainScene.CityWeather]?
}
