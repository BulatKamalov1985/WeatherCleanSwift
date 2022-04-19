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

    func requestInitForm(_ request: MainScene.InitForm.Request) {
        print("start worker.get(request)")
        worker.get(request) { [weak self] result in
            print("comletion worker result")
            DispatchQueue.main.async {
                guard let succes = try? result.get()
                else {
                    self?.presenter.presentErrorAlertController()
                    return
                }
                self?.presenter.presentInitForm(succes)
                //                switch result {
                //                case .success(let weather): self?.presenter.presentInitForm(weather)
                //                case.failure(_): self?.presenter.presentErrorAlertController()

            }
        }
    }
}
