//
//  WeatherCell.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 14.04.2022.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.textColor = .white
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = .boldSystemFont(ofSize: 25)
        locationLabel.textAlignment = .left
        return locationLabel
    }()
    var countryLabel: UILabel = {
        let countryLabel = UILabel()
        countryLabel.textColor = .white
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.font = .boldSystemFont(ofSize: 15)
        countryLabel.textAlignment = .left
        return countryLabel
    }()
    var currentTemperatureLabel: UILabel = {
        let currentTemperatureLabel = UILabel()
        currentTemperatureLabel.textColor = .white
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.font = .boldSystemFont(ofSize: 40)
        currentTemperatureLabel.textAlignment = .right
        return currentTemperatureLabel
    }()
    var lowTemperatureLabel: UILabel = {
        let lowTemperatureLabel = UILabel()
        lowTemperatureLabel.textColor = .white
        lowTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTemperatureLabel.font = .boldSystemFont(ofSize: 15)
        lowTemperatureLabel.textAlignment = .center
        return lowTemperatureLabel
    }()
    var highTemperatureLabel: UILabel = {
        let highTemperatureLabel = UILabel()
        highTemperatureLabel.textColor = .white
        highTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        highTemperatureLabel.font = .boldSystemFont(ofSize: 15)
        highTemperatureLabel.textAlignment = .center
        return highTemperatureLabel
    }()
    var pressureLabel: UILabel = {
        let pressureLabel = UILabel()
        pressureLabel.textColor = .white
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.font = .boldSystemFont(ofSize: 15)
        pressureLabel.textAlignment = .left
        return pressureLabel
    }()
    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 20
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true

        backgroundImageView.addSubview(locationLabel)
        locationLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20).isActive = true
        locationLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 15).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        locationLabel.textColor = .white

        backgroundImageView.addSubview(countryLabel)
        countryLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20).isActive = true
        countryLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5).isActive = true

        backgroundImageView.addSubview(currentTemperatureLabel)
        currentTemperatureLabel.topAnchor.constraint(
            equalTo: backgroundImageView.topAnchor, constant: 5
        ).isActive = true
        currentTemperatureLabel.trailingAnchor.constraint(
            equalTo: backgroundImageView.trailingAnchor, constant: -10
        ).isActive = true
        currentTemperatureLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true

        backgroundImageView.addSubview(lowTemperatureLabel)
        lowTemperatureLabel.trailingAnchor.constraint(
            equalTo: backgroundImageView.trailingAnchor, constant: -20
        ).isActive = true
        lowTemperatureLabel.topAnchor.constraint(
            equalTo: currentTemperatureLabel.bottomAnchor, constant: 15
        ).isActive = true

        backgroundImageView.addSubview(highTemperatureLabel)
        highTemperatureLabel.trailingAnchor.constraint(
            equalTo: lowTemperatureLabel.leadingAnchor, constant: -5
        ).isActive = true
        highTemperatureLabel.topAnchor.constraint(
            equalTo: currentTemperatureLabel.bottomAnchor, constant: 15
        ).isActive = true

        backgroundImageView.addSubview(pressureLabel)
        pressureLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20).isActive = true
        pressureLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 10).isActive = true
        pressureLabel.widthAnchor.constraint(equalToConstant: 195).isActive = true
    }
    func configure(object: MainScene.CityWeather, indexPath: Int) {
        self.backgroundImageView.image = UIImage(named: "blue sky")
        self.locationLabel.text = object.name
        self.countryLabel.text = object.sys.country
        self.currentTemperatureLabel.text = "\(object.main.temp)°"
        self.lowTemperatureLabel.text = "L: \(object.main.tempMin)°"
        self.highTemperatureLabel.text = "H: \(object.main.tempMax)°"
        self.pressureLabel.text = "Pressure: \(object.main.pressure)"
    }
}
