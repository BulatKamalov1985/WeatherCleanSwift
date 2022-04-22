//
//  WorkerTests.swift
//  WeatherCleanSwiftTests
//
//  Created by Bulat Kamalov on 21.04.2022.
//

import Foundation
import XCTest
@testable import WeatherCleanSwift

final class WorekerTests: XCTestCase {
    func testferstLoad() {
        let storageMock = StorageMock()
        let worker = MainSceneWorker(storage: storageMock)
        let request = MainScene.InitForm.Request(firstLoad: true)
        worker.getBaseWeather(request, completion: { _ in })
        XCTAssertTrue(request.firstLoad, "первая загрузка флаг должен быть TRUE")
    }
    func testloadObjectTest() {
        let storage = StorageMock()
        let worker = MainSceneWorker(storage: storage)
        let request = MainScene.InitForm.Request(firstLoad: true)
        worker.getBaseWeather(request, completion: { _ in })
        XCTAssertTrue(storage.loadObjectTest, "функция loadObject должна быть вызывана флаг TRUE")
    }
    func testAddCity() {
        let addCityExpection = XCTestExpectation(description: "Добавляем город")
        let storageMock = StorageMock()
        let worker = MainSceneWorker(storage: storageMock)
        let request = MainScene.InitForm.Request(firstLoad: false, cityWeather: "ufa")
        worker.getBaseWeather(request, completion: { _ in
            addCityExpection.fulfill()
        })
        wait(for: [addCityExpection], timeout: 2)
        XCTAssertFalse(request.firstLoad, "заходим не впервые возвращаем флаг false")
        XCTAssertTrue(storageMock.saveObjectTests, "объект должен сохраняться и возвращать флаг true")
    }
    func testFailureCase() {
        let addCityExpection = XCTestExpectation(description: "Добавляем город")
        let storageMock = StorageMock()
        let worker = MainSceneWorker(storage: storageMock)
        let request = MainScene.InitForm.Request(firstLoad: false, cityWeather: "hgkvjk")
        worker.getBaseWeather(request, completion: { _ in
            addCityExpection.fulfill()
        })
        wait(for: [addCityExpection], timeout: 2)
        XCTAssertFalse(request.firstLoad, "заходим не впервые возвращаем флаг false")
        XCTAssertFalse(storageMock.saveObjectTests, "мы не заходим в saveObject и возвращать флаг False")
    }
}
