//
//  DailyWeatherCollectionViewCell.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//

import UIKit

class DailyWeatherCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = Constants.cellIdentifier
    
    private let dayLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   label.textAlignment = .center
	   label.font = .systemFont(ofSize: Constants.fontDayLabel,
						   weight: .regular)
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
    
    private let minTempLabel: UILabel = {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   label.textAlignment = .center
	   label.font = .systemFont(ofSize: Constants.fontTempLabel,
						   weight: .regular)
	   return label
    }()
    
    override init(frame: CGRect) {
	   super.init(frame: frame)
	   contentView.addSubview(dayLabel)
	   contentView.addSubview(tempLabel)
	   contentView.addSubview(minTempLabel)
	   
	   addConstraints()
    }
    
    required init?(coder: NSCoder) {
	   fatalError("init(coder:) has not been implemented")
    }
    //MARK: - functions
    private func addConstraints() {
	   NSLayoutConstraint.activate([
		  dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
		  dayLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
		  dayLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
		  
		  tempLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor),
		  tempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
		  tempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
		  tempLabel.heightAnchor.constraint(equalToConstant: Constants.heightAnchorTemp),
		  
		  minTempLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor),
		  minTempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
		  minTempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
		  minTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
									    constant: Constants.bottomAnchorMinTemp),
	   ])
    }
    
    override func prepareForReuse() {
	   super.prepareForReuse()
	   dayLabel.text = nil
	   tempLabel.text = nil
	   minTempLabel.text = nil
    }
    
    public func configure(with viewModel: DailyWeatherCollectionViewCellViewModel) {
	   dayLabel.text = viewModel.day
	   tempLabel.text = viewModel.temperature
	   minTempLabel.text = viewModel.temperatureMin
    }
}

//MARK: -  extension constants

fileprivate extension DailyWeatherCollectionViewCell {
    enum Constants {
	   static let fontDayLabel = 13.0
	   static let fontTempLabel = 10.0
	   static let heightAnchorTemp = 20.0
	   static let bottomAnchorMinTemp = -20.0
	   static let cellIdentifier = "DailyWeatherCollectionViewCell"
    }
}
