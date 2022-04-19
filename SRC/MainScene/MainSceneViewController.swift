//
//  MainSceneViewController.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainSceneViewController: ViewController, MainSceneDisplayLogic {

    private let weatherLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.textColor = .white
        weatherLabel.text = "Weather"
        weatherLabel.font = .boldSystemFont(ofSize: 35)
        return weatherLabel
    }()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a city or airport"
        searchBar.barTintColor = .black
        searchBar.searchTextField.textColor = .lightGray
        searchBar.layer.cornerRadius = 10
        return searchBar
    }()
    private let rightBarButton =  UIBarButtonItem()
    private var collectionView: UICollectionView?

    private var weatherModel: [MainScene.InitForm.ViewModel] = []
    private var weatherModelFiltred: [MainScene.InitForm.ViewModel] = []

    private let interactor: MainSceneBusinessLogic
    private let router: MainSceneRoutingLogic

    init(
        interactor: MainSceneBusinessLogic,
        router: MainSceneRoutingLogic
    ) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.addSubview(weatherLabel)
        view.addSubview(searchBar)
        setupCollectionView()
        setupWeatherLabel()
        setupSearchBar()
        setupRightButtonItem()
        view.backgroundColor = .black
        setupAlert()

    }

    func setupCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "weatherCell")
        collectionView.alwaysBounceVertical = true

        collectionView.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 50).isActive =  true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive =  true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 240).isActive = true
        self.collectionView = collectionView
    }

    func setupWeatherLabel() {
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        weatherLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        weatherLabel.widthAnchor.constraint(equalToConstant: 143).isActive = true
        weatherLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    func setupSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.widthAnchor.constraint(equalToConstant: 340).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 141).isActive = true
    }

    func setupRightButtonItem() {
        let button = UIBarButtonItem(image: UIImage(named: "button"), style: .plain, target: self, action: #selector(setupAlert))
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }

    @objc func setupAlert() {

        let alert = UIAlertController(title: "Add City?", message: "Pleace add city", preferredStyle: .alert)
        let findCityAction = UIAlertAction(title: "Add", style: .default) { [weak alert] _ in
            self.initForm(cityName: alert?.textFields?.first?.text ?? "")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addTextField { textField in
            textField.placeholder = "City"
        }

        alert.addAction(findCityAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)

    }

    func errorAlertController () {
        let errorAC = UIAlertController(title: "Sorry", message: "We did not find such a city", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        errorAC.addAction(okAction)
        present(errorAC, animated: true, completion: nil)
    }

    // MARK: - MainSceneDisplayLogic

    func displayInitForm(_ viewModel: MainScene.InitForm.ViewModel) {
        print(viewModel)
        weatherModel.append(viewModel)
        self.weatherModelFiltred = self.weatherModel
        collectionView?.reloadData()
    }

    private func initForm(cityName: String) {
        if weatherModel.isEmpty {
            interactor.requestInitForm(MainScene.InitForm.Request.cityWeather(cityName))
        }
    }
}

extension MainSceneViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.weatherModelFiltred.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCell

        let weatherModel = self.weatherModelFiltred[indexPath.row]

        cell.configure(weatherModel: weatherModel, indexPath: indexPath)

        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (self.collectionView?.frame.size.width) ?? 200, height: 120)

    }
}

extension MainSceneViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        self.weatherModelFiltred = self.weatherModel
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        self.weatherModelFiltred = weatherModel.filter { $0.name.hasPrefix(searchText)}
        //        self.weatherModelFiltred = searchText.isEmpty ? weatherModel : weatherModel.filter({ viewModel in
        //            return viewModel.name.range(of: searchText, options: .caseInsensitive) != nil
        //        })
        self.collectionView?.reloadData()
    }
}
