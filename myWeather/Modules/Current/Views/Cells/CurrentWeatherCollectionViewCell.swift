//
//  CurrentWeatherCollectionViewCell.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = Constants.cellIdentifier
    
    private let cityLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   label.textAlignment = .center
	   label.font = .systemFont(ofSize: Constants.fontCityLabel,
						   weight: .medium)
	   return label
    }()
    
    private let tempLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   label.textAlignment = .center
	   label.font = .systemFont(ofSize: Constants.fontTempLabel,
						   weight: .regular)
	   return label
    }()
    
    private let descriptionLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   label.textAlignment = .center
	   label.font = .systemFont(ofSize: Constants.fontOtherLabel,
						   weight: .regular)
	   return label
    }()
    
    private let windLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   label.textAlignment = .center
	   label.font = .systemFont(ofSize: Constants.fontOtherLabel,
						   weight: .regular)
	   return label
    }()
    
    private let tempMinLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   label.textAlignment = .center
	   label.font = .systemFont(ofSize: Constants.fontOtherLabel,
						   weight: .regular)
	   return label
    }()
    
    private let tempMaxLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   label.textAlignment = .left
	   label.font = .systemFont(ofSize: Constants.fontOtherLabel,
						   weight: .regular)
	   return label
    }()
    
    private lazy var stackView: UIStackView = {
	   let stack = UIStackView(arrangedSubviews: [self.tempMaxLabel,
										 self.tempMinLabel])
	   stack.translatesAutoresizingMaskIntoConstraints = false
	   stack.axis = .horizontal
	   stack.spacing = Constants.spacingStack
	   return stack
    }()
    
    override init(frame: CGRect) {
	   super.init(frame: frame)
	   contentView.addSubview(cityLabel)
	   contentView.addSubview(tempLabel)
	   contentView.addSubview(descriptionLabel)
	   contentView.addSubview(stackView)
	   contentView.addSubview(windLabel)
	   
	   addConstraint()
    }
    
    required init?(coder: NSCoder) {
	   fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraint() {
	   NSLayoutConstraint.activate([
		  cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
		  cityLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
		  cityLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
		  
		  tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
		  tempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
		  tempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
		  
		  descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor,
										constant: Constants.topAnchorLabel),
		  descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
		  descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
		  
		  windLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
								   constant: Constants.topAnchorLabel),
		  windLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
		  windLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
		  
		  stackView.topAnchor.constraint(equalTo: windLabel.bottomAnchor),
		  stackView.heightAnchor.constraint(equalToConstant: Constants.heightAnchorStack),
		  stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
		  stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
									 constant: Constants.bottomAnchorStack)
		  
	   ])
    }
    
    override func prepareForReuse() {
	   super.prepareForReuse()
	   cityLabel.text = nil
	   tempLabel.text = nil
    }
    
    public func configure(with viewModel: CurrentWeatherCollectionViewCellViewModel) {
	   cityLabel.text = viewModel.city
	   tempLabel.text = "\(viewModel.temp)ºC"
	   tempMaxLabel.text = "Max: \(viewModel.tempMax)ºC,"
	   tempMinLabel.text = "min: \(viewModel.tempMin)ºC"
	   descriptionLabel.text = "It's \(viewModel.desc ?? "oops") outside"
	   windLabel.text = "Wind speed: \(viewModel.wind ?? -100) m/s"
    }
}
//MARK: -  extension constants

fileprivate extension CurrentWeatherCollectionViewCell {
    enum Constants {
	   static let fontCityLabel = 24.0
	   static let fontTempLabel = 36.0
	   static let fontOtherLabel = 14.0
	   static let spacingStack = 3.0
	   static let topAnchorLabel = 30.0
	   static let heightAnchorStack = 40.0
	   static let bottomAnchorStack = -20.0
	   static let cellIdentifier = "CurrentWeatherCollectionViewCell"
    }
}
