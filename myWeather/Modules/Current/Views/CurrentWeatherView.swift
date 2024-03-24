//
//  CurrentWeatherView.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//

import UIKit

final class CurrentWeatherView: UIView {
    
    private var viewModel: [WeatherViewModel] = []
    
    private var collectionView: UICollectionView?
    private var locationDeniedLabel: UILabel?
    
    override init(frame: CGRect) {
	   super.init(frame: frame)
	   translatesAutoresizingMaskIntoConstraints = false
	   
	   createCollectionView()
	   createLocationDeniedLabel()
    }
    
    required init?(coder: NSCoder) {
	   fatalError("init(coder:) has not been implemented")
    }
    //MARK: - functions
    public func configure(with viewModel: [WeatherViewModel]) {
	   self.viewModel = viewModel
	   collectionView?.reloadData()
    }
    
    private func createCollectionView() {
	   let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
		  return self.layout(for: sectionIndex)
	   }
	   let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
	   collectionView.translatesAutoresizingMaskIntoConstraints = false
	   collectionView.dataSource = self
	   collectionView.register(CurrentWeatherCollectionViewCell.self,
						  forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier)
	   collectionView.register(DailyWeatherCollectionViewCell.self,
						  forCellWithReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier)
	   
	   addSubview(collectionView)
	   
	   NSLayoutConstraint.activate([
		  collectionView.topAnchor.constraint(equalTo: topAnchor),
		  collectionView.leftAnchor.constraint(equalTo: leftAnchor),
		  collectionView.rightAnchor.constraint(equalTo: rightAnchor),
		  collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
	   ])
	   
	   self.collectionView = collectionView
    }
    
    private func layout(for sectionIndex: Int) -> NSCollectionLayoutSection {
	   let section = CurrentWeatherSection.allCases[sectionIndex]
	   
	   switch section {
	   case .current:
		  let item = NSCollectionLayoutItem(layoutSize: .init(
			 widthDimension: .fractionalWidth(Constants.currentFractionalWidthHeight),
			 heightDimension: .fractionalHeight(Constants.currentFractionalWidthHeight)))
		  let group = NSCollectionLayoutGroup.vertical(
			 layoutSize: .init(widthDimension: .fractionalWidth(Constants.currentWidthDimension),
						    heightDimension: .fractionalWidth(Constants.currentHeightDimension)),
			 subitems: [item])
		  return NSCollectionLayoutSection(group: group)
	   case .daily:
		  let item = NSCollectionLayoutItem(layoutSize: .init(
			 widthDimension: .fractionalWidth(Constants.dailyFractionalWidthHeight),
			 heightDimension: .fractionalHeight(Constants.dailyFractionalWidthHeight)))
		  
		  let group = NSCollectionLayoutGroup.horizontal(
			 layoutSize: .init(widthDimension: .fractionalWidth(Constants.dailyWidthDimension),
						    heightDimension: .absolute(Constants.dailyHeightDimension)),
			 subitems: [item])
		  group.contentInsets = .init(top: Constants.dailyContentInsets,
								leading: Constants.dailyContentInsets,
								bottom: Constants.dailyContentInsets,
								trailing: Constants.dailyContentInsets
		  )
		  
		  let section = NSCollectionLayoutSection(group: group)
		  section.orthogonalScrollingBehavior = .continuous
		  return section
	   }
    }
    
    func createLocationDeniedLabel() {
	   let label = UILabel()
	   label.translatesAutoresizingMaskIntoConstraints = false
	   label.text = Constants.deniedLabel
	   label.textAlignment = .center
	   label.font = .systemFont(ofSize: Constants.fontDenied,
						   weight: .regular)
	   label.textColor = .red
	   label.numberOfLines = Constants.linesDenied
	   label.lineBreakMode = .byWordWrapping
	   addSubview(label)
	   
	   NSLayoutConstraint.activate([
		  label.centerXAnchor.constraint(equalTo: centerXAnchor),
		  label.centerYAnchor.constraint(equalTo: centerYAnchor)
	   ])
	   
	   self.locationDeniedLabel = label
    }
    
    ///Method to control the visibility of the locationDeniedLabel label
    func showLocationDeniedLabel(_ show: Bool) {
	   locationDeniedLabel?.isHidden = !show
    }
}
//MARK: -  extension functions Collections
extension CurrentWeatherView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
	   return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
	   switch viewModel[section] {
	   case .current:
		  return Constants.currentCell
	   case .daily(let viewModels):
		  return viewModels.count
	   }
    }
    
    func collectionView(_ collectionView: UICollectionView,
				    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	   
	   switch viewModel[indexPath.section] {
	   case .current(let viewModel):
		  guard let cell = collectionView.dequeueReusableCell(
			 withReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier,
			 for: indexPath) as? CurrentWeatherCollectionViewCell else {
			 fatalError()
		  }
		  cell.configure(with: viewModel)
		  return cell
		  
	   case .daily(let viewModels):
		  guard let cell = collectionView.dequeueReusableCell(
			 withReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier,
			 for: indexPath) as? DailyWeatherCollectionViewCell else {
			 fatalError()
		  }
		  cell.configure(with: viewModels[indexPath.row])
		  cell.layer.cornerRadius = Constants.cellDailyCornerRadius
		  cell.layer.borderWidth = Constants.cellDailyBorderWidth
		  cell.layer.borderColor = UIColor.secondaryLabel.cgColor
		  cell.backgroundColor = .secondarySystemBackground
		  return cell
	   }
    }
}

//MARK: -  extension constants

fileprivate extension CurrentWeatherView {
    enum Constants {
	   static let cellDailyCornerRadius = 8.0
	   static let cellDailyBorderWidth = 1.0
	   static let linesDenied = 2
	   static let fontDenied = 16.0
	   static let dailyContentInsets = 2.0
	   static let dailyFractionalWidthHeight = 1.0
	   static let dailyHeightDimension = 150.0
	   static let dailyWidthDimension = 0.25
	   static let currentFractionalWidthHeight = 1.0
	   static let currentWidthDimension = 1.0
	   static let currentHeightDimension = 0.75
	   static let currentCell = 1
	   static let deniedLabel = "Geolocation access disabled.\nEnable access in settings."
    }
}
