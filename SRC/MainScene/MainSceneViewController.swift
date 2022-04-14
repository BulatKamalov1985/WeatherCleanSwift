//
//  MainSceneViewController.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainSceneViewController: ViewController, MainSceneDisplayLogic {
    
    private let weatherLabel = UILabel()
    private let searchBar = UISearchBar()
    private let rightBarButton =  UIBarButtonItem()
    
    private var weatherModel: [MainScene.InitForm.ViewModel] =
    [MainScene.InitForm.ViewModel(location: "Ufa", realTime: "13:20", currentTemperature: "33˚", lowTemperature: "L: 20˚", highTemperature: "H: 44˚", description: "Sun"),
     MainScene.InitForm.ViewModel(location: "Sochi", realTime: "13:20", currentTemperature: "29˚", lowTemperature: "L: 19˚", highTemperature: "H: 55˚", description: "Rainy")]
    
    
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
        initForm()
        view.addSubview(weatherLabel)
        view.addSubview(searchBar)
        setupCollectionView()
        setupWeatherLabel()
        setupSearchBar()
        setupButton()
        view.backgroundColor = .black
    }
    
    
    func setupCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 50).isActive =  true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: 340).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 700).isActive = true
    }
    
    private func createLayout() -> UICollectionViewLayout {
        // section -> group -> items -> size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize:  itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5,
                                                     bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.17))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize ,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func setupWeatherLabel() {
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        weatherLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        weatherLabel.widthAnchor.constraint(equalToConstant: 143).isActive = true
        weatherLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        weatherLabel.textColor = .white
        weatherLabel.text = "Weather"
        weatherLabel.font = UIFont(name: "SFProDisplay-Bold", size: 88)
        
        
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "Search for a city or airport"
        searchBar.barTintColor = .black
        searchBar.searchTextField.textColor = .lightGray
        searchBar.layer.cornerRadius = 10
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.widthAnchor.constraint(equalToConstant: 340).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 141).isActive = true
    }
    
    func setupButton() {
        let button = UIBarButtonItem(image: UIImage(named: "button"), style: .plain, target: nil, action: nil)
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }
    
    
    
    // MARK: - MainSceneDisplayLogic
    
    func displayInitForm(_ viewModel: MainScene.InitForm.ViewModel) {}
    
    // MARK: - Private
    
    private func initForm() {
        interactor.requestInitForm(MainScene.InitForm.Request())
    }
}

extension MainSceneViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  weatherModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherCell
        
        let weatherModel = weatherModel[indexPath.row]
        if indexPath.row == 0 {
            cell.backgroundImageView.image = UIImage(named: "dark sky")
        } else {
            cell.backgroundImageView.image = UIImage(named: "blue sky")        }
        cell.locationLabel.text = weatherModel.location
        cell.realTimeLabel.text = weatherModel.realTime
        cell.currentTemperatureLabel.text = weatherModel.currentTemperature
        cell.lowTemperatureLabel.text = weatherModel.lowTemperature
        cell.highTemperatureLabel.text = weatherModel.highTemperature
        cell.descriptionLabel.text = weatherModel.description
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
      
        
        return cell
    }
    
}

