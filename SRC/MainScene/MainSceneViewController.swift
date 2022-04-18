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
    private var collectionView: UICollectionView?
    
    private var weatherModel: [ViewModel] = []
  
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
        weatherLabel.textColor = .white
        weatherLabel.text = "Weather"
        weatherLabel.font = .boldSystemFont(ofSize: 35)
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
    
    func displayInitForm(_ viewModel: ViewModel) {
        weatherModel.append(viewModel)
        collectionView?.reloadData()
    }
    
    // MARK: - Private
    
    private func initForm() {
        interactor.requestInitForm(.cityWeather("denpasar"))
        interactor.requestInitForm(.cityWeather("ufa"))
        interactor.requestInitForm(.cityWeather("sochi"))
        interactor.requestInitForm(.cityWeather("voronezh"))
        interactor.requestInitForm(.cityWeather("batumi"))
        interactor.requestInitForm(.cityWeather("moscow"))
        interactor.requestInitForm(.cityWeather("paris"))
        interactor.requestInitForm(.cityWeather("hanoi"))

    }
}

extension MainSceneViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  weatherModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCell
        
        let weatherModel = weatherModel[indexPath.row]
        
        cell.configure(weatherModel: weatherModel, indexPath: indexPath)
        
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            CGSize(width: (self.collectionView?.frame.size.width) ?? 200, height: 120)
    
        }
}

