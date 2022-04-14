//
//  WeatherCell.swift
//  WeatherCleanSwift
//
//  Created by Bulat Kamalov on 14.04.2022.
//

import UIKit

class WeatherCell : UICollectionViewCell {
    
    var locationLabel = UILabel()
    var realTimeLabel = UILabel()
    var currentTemperatureLabel = UILabel()
    var lowTemperatureLabel = UILabel()
    var highTemperatureLabel = UILabel()
    var descriptionLabel = UILabel()
    var backgroundImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createbackgroundImageView()
        createLocationLabel()
        createRealTimeLabel()
        createCurrentTemperatureLabel()
        createLowTemperatureLabel()
        createHighTemperatureLabel()
        createDescriptionLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createbackgroundImageView() {
        backgroundImageView = UIImageView()
        backgroundImageView.layer.cornerRadius = 20
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
    }
    
    private func createLocationLabel() {
        locationLabel = UILabel()
        locationLabel.textColor = .white
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font =  .boldSystemFont(ofSize: 25)
        locationLabel.textAlignment = .left
        backgroundImageView.addSubview(locationLabel)
        locationLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20).isActive = true
        locationLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 10).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func createRealTimeLabel() {
        realTimeLabel = UILabel()
        realTimeLabel.textColor = .white
        realTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        realTimeLabel.font =  .boldSystemFont(ofSize: 15)
        realTimeLabel.textAlignment = .left
        backgroundImageView.addSubview(realTimeLabel)
        realTimeLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20).isActive = true
        realTimeLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    private func createCurrentTemperatureLabel() {
        currentTemperatureLabel = UILabel()
        currentTemperatureLabel.textColor = .white
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.font =  .boldSystemFont(ofSize: 50)
        currentTemperatureLabel.textAlignment = .center
        backgroundImageView.addSubview(currentTemperatureLabel)
        currentTemperatureLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 0).isActive = true
        currentTemperatureLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: 5).isActive = true
        currentTemperatureLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func createLowTemperatureLabel() {
        lowTemperatureLabel = UILabel()
        lowTemperatureLabel.textColor = .white
        lowTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTemperatureLabel.font =  .boldSystemFont(ofSize: 15)
        lowTemperatureLabel.textAlignment = .center
        backgroundImageView.addSubview(lowTemperatureLabel)
        lowTemperatureLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -20).isActive = true
        lowTemperatureLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 15).isActive = true
        
    }
    
    private func createHighTemperatureLabel() {
        highTemperatureLabel = UILabel()
        highTemperatureLabel.textColor = .white
        highTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        highTemperatureLabel.font =  .boldSystemFont(ofSize: 15)
        highTemperatureLabel.textAlignment = .center
        backgroundImageView.addSubview(highTemperatureLabel)
        highTemperatureLabel.trailingAnchor.constraint(equalTo: lowTemperatureLabel.leadingAnchor, constant: -5).isActive = true
        highTemperatureLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 15).isActive = true
        
        
    }
    
    private func createDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.textColor = .white
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font =  .boldSystemFont(ofSize: 15)
        descriptionLabel.textAlignment = .left
        backgroundImageView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: realTimeLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 195).isActive = true
        
    }
    
    
}
