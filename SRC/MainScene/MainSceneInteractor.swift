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
        DispatchQueue.main.async {
            self.presenter.presentInitForm(MainScene.InitForm.Response())
        }
    }
}
