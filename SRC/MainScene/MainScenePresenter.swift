//
//  MainScenePresenter.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class MainScenePresenter: MainScenePresentationLogic {
    
    
    weak var viewController: MainSceneDisplayLogic?

    func presentInitForm(_ response: MainScene.InitForm.Response) {
        viewController?.displayInitForm(MainScene.InitForm.ViewModel(location: "Ufa", realTime: "32:34", currentTemperature: "23", lowTemperature: "13", highTemperature: "44", description: "all goocd"))
    }
}
