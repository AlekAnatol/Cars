//
//  CarListViewController.swift
//  Cars1
//
//  Created by Екатерина Алексеева on 07.08.2023.
//

import UIKit

class CarListViewController: UIViewController {

    //MARK: - outlets
    
    @IBOutlet weak var sortedButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var carListTableView: UITableView!
    
    //MARK: - private properties
    
    private var carsArray: [Car] = []
    private var isSortedByPrice = false
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carListTableView.register(UINib(nibName: "CarCell", bundle: nil),
                                  forCellReuseIdentifier: CarCell.reuseIdentifier)
        carListTableView.dataSource = self
        carListTableView.delegate = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carsArray = Storage.share.allCars
        carListTableView.reloadData()
        print(carsArray.count)
    }
   
    //MARK: -  actions
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "carSettingsViewController")
        self.present(nextViewController, animated: true)
    }
    
    @IBAction func sortedButtonPressed(_ sender: Any) {
        isSortedByPrice.toggle()
        if isSortedByPrice {
            carsArray = carsArray.sorted { $0.price > $1.price }
        } else {
            carsArray = Storage.share.allCars
        }
        carListTableView.reloadData()
    }
}

//MARK: - tableViewDataSource

extension CarListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarCell.reuseIdentifier) as? CarCell
        else { return UITableViewCell() }
        cell.manufacturerAndModel.text = String(carsArray[indexPath.row].manufacturer.rawValue) +
                                        ", " + String(carsArray[indexPath.row].model.rawValue)
        cell.price.text = String(carsArray[indexPath.row].price)
        cell.typeOfDrive.text = String(carsArray[indexPath.row].typeOfDrive.rawValue)
        cell.transmission.text = String(carsArray[indexPath.row].transmission.rawValue)
        cell.engineVolume.text = String(carsArray[indexPath.row].engineVolume.rawValue)
        return cell
    }
}

//MARK: - tableViewDelegate

extension CarListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "carSettingsViewController") as? CarSettingsViewController else { return }
        nextViewController.car = carsArray[indexPath.row]
        self.present(nextViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

//MARK: - searchBarDelegate

extension CarListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            carsArray = Storage.share.allCars
        }
        else {
            carsArray = Storage.share.allCars.filter({ car in
                car.manufacturer.rawValue.lowercased().contains(searchText.lowercased()) ||
                car.model.rawValue.lowercased().contains(searchText.lowercased())
            })
        }
        carListTableView.reloadData()
    }
}
