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
    private let rightBarButton = UIBarButtonItem()
    private var collectionView: UICollectionView?

    private var weatherModel: MainScene.InitForm.ViewModel?
    private var weatherModelFiltred: MainScene.InitForm.ViewModel?
    private var isSearchingInSearchBar: Bool = false

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
        setupSearchBar()
        setupCollectionView()
        setupWeatherLabel()
        setupRightButtonItem()
        view.backgroundColor = .black
//        setupAlert()
        searchBar.delegate = self
        initForm()
    }

    func displayStorageIsEmpty() {
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

        collectionView.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0
        ).isActive = true
        collectionView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0
        ).isActive = true
        collectionView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 240
        ).isActive = true
        self.collectionView = collectionView
    }

    func setupWeatherLabel() {
        view.addSubview(weatherLabel)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        weatherLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        weatherLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 141).isActive = true
    }

    func setupRightButtonItem() {
        let button = UIBarButtonItem(
            image: UIImage(named: "button"),
            style: .plain,
            target: self,
            action: #selector(setupAlert)
        )
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }

    @objc func setupAlert() {
        let alert = UIAlertController(title: "Add City?", message: "Pleace add city", preferredStyle: .alert)
        let findCityAction = UIAlertAction(title: "Add", style: .default) { [weak alert] _ in
            guard let textFields = alert?.textFields else { return }
            if let cityText = textFields.first?.text {
                self.interactor.requestInitForm(MainScene.InitForm.Request(firstLoad: false, cityWeather: cityText))
            }
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
        if weatherModel == nil {
            self.weatherModel = .init(cityWeather: viewModel.cityWeather)
        } else {
            self.weatherModel?.cityWeather.append(contentsOf: viewModel.cityWeather)
        }
        collectionView?.reloadData()
    }
    private func initForm() {
            interactor.requestInitForm(MainScene.InitForm.Request(firstLoad: true))
        }
    }
extension MainSceneViewController: UICollectionViewDataSource,
                                   UICollectionViewDelegate,
                                   UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchingInSearchBar {
            return weatherModelFiltred?.cityWeather.count ?? 1
        } else {
            return weatherModel?.cityWeather.count ?? 1
        }
    }
    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "weatherCell",
                for: indexPath
            ) as? WeatherCell else { return UICollectionViewCell() }
        var object: MainScene.CityWeather?
        if isSearchingInSearchBar {
            object = weatherModelFiltred?.cityWeather[indexPath.row]
        } else {
            object = weatherModel?.cityWeather[indexPath.row]
        }
        if let object = object {
            cell.configure(object: object, indexPath: indexPath.row)
        }
        return cell
}

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: (self.collectionView?.frame.size.width) ?? 200, height: 120)
    }
}

extension MainSceneViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            weatherModelFiltred?.cityWeather.removeAll()
            isSearchingInSearchBar = false
        } else {
            isSearchingInSearchBar = true
        }
        collectionView?.reloadData()
    }
}
