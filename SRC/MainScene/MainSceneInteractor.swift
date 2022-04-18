//
//  MainSceneInteractor.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation

final class MainSceneInteractor: MainSceneBusinessLogic, MainSceneDataStore {
    private let presenter: MainScenePresentationLogic
    private let worker: MainSceneWorkerLogic
    
    init(
        presenter: MainScenePresentationLogic,
        worker: MainSceneWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func requestInitForm(_ request: RequestModel) {
        print("start worker.get(request)")
        worker.get(request) { [weak self] result in
            print("comletion worker result")
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    print("presenter.presentInitForm(weather)", weather.main.temp)
                    self?.presenter.presentInitForm(weather)
                case .failure(_): return
                }
            }
        }
    }
}
