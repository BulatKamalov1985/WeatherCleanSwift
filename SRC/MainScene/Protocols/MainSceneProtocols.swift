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
    func requestInitForm(_ request: RequestModel)
}

protocol MainSceneWorkerLogic {
    func get(_ request: RequestModel, completion: @escaping (Result<ResponseModel, NetworkError>) -> Void)
}

protocol MainScenePresentationLogic {
    func presentInitForm(_ response: ResponseModel)
}

protocol MainSceneDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: ViewModel)
}

protocol MainSceneRoutingLogic {}
