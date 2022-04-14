//
//  MainSceneAssembly.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum MainSceneAssembly {
    static func build() -> UIViewController {
        let presenter = MainScenePresenter()
        let worker = MainSceneWorker()
        let interactor = MainSceneInteractor(presenter: presenter, worker: worker)
        let router = MainSceneRouter(dataStore: interactor)
        let viewController = MainSceneViewController(interactor: interactor, router: router)

        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
