//
//  SettingsView.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//

import UIKit
///useful for transmitting data for other controllers (for the future)
protocol SettingsViewDelegate: AnyObject {
    func settingsView(_ settingsView: SettingsView, didTap option: SettingOption)
}

final class SettingsView: UIView {
    
    weak var delegate: SettingsViewDelegate?
    
    private var viewModel: SettingsViewViewModel? {
	   didSet {
		  tableView.reloadData()
	   }
    }
    
    private let tableView: UITableView = {
	   let table = UITableView()
	   table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	   table.translatesAutoresizingMaskIntoConstraints = false
	   return table
    }()
    
    override init(frame: CGRect) {
	   super.init(frame: frame)
	   translatesAutoresizingMaskIntoConstraints = false
	   addSubview(tableView)
	   tableView.delegate = self
	   tableView.dataSource = self
	   NSLayoutConstraint.activate([
		  tableView.topAnchor.constraint(equalTo: topAnchor),
		  tableView.rightAnchor.constraint(equalTo: rightAnchor),
		  tableView.leftAnchor.constraint(equalTo: leftAnchor),
		  tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
	   ])
    }
    
    required init?(coder: NSCoder) {
	   fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: SettingsViewViewModel) {
	   self.viewModel = viewModel
    }
}
//MARK: -  extension UITableViewDelegate, UITableViewDataSource
extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	   return viewModel?.options.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	   let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
	   if let viewModel {
		  cell.textLabel?.text = viewModel.options[indexPath.row].title
	   }
	   return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	   tableView.deselectRow(at: indexPath, animated: true)
	   
	   guard let viewModel else { return }
	   let option = viewModel.options[indexPath.row]
	   
	   delegate?.settingsView(self, didTap: option)
    }
}
