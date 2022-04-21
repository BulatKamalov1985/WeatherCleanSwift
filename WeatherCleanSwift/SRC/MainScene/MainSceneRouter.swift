//
//  MainSceneRouter.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainSceneRouter: MainSceneRoutingLogic, MainSceneDataPassing {
    weak var viewController: UIViewController?
    let dataStore: MainSceneDataStore

    init(dataStore: MainSceneDataStore) {
        self.dataStore = dataStore
    }
}

private extension MainSceneRouter {
}
