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
// получаем данные из VC
    func requestInitForm(_ request: MainScene.InitForm.Request) {
        print("start worker.get(request)")
        worker.getBaseWeather(request) {[weak self] result in
            print("comletion worker result")
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    print("case .success(let success):")
                    let response = MainScene.InitForm.Response(cityWeather: success)
                    self?.presenter.presentInitForm(response)
                case .failure(let error):
                    print("case .failure(let error):")
                    if error == .srorageIsEmty {
                        self?.presenter.presentStorageIsEmty()
                    } else {
                        self?.presenter.presentErrorAlertController()
                    }
                }
            }
        }
    }
}
