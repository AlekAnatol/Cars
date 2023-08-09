//
//  CarSettingsViewController.swift
//  Cars1
//
//  Created by Екатерина Алексеева on 07.08.2023.
//

import UIKit

class CarSettingsViewController: UIViewController {

    //MARK: - outlets
    
    @IBOutlet weak var carSettingsTableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!

    //MARK: - private properties
    
    private let reuseIdentifier = "reuseIdentifier"
    private var selectedIndexPath: [IndexPath] = []
    private var isFromAddButton = true
    
    //MARK: - public properties
    
    var car: Car!
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carSettingsTableView.dataSource = self
        carSettingsTableView.delegate = self
        carSettingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        if car != nil {
            isFromAddButton = false
        } else {
            car = Car(carManufacturer: .volkswagen,
                      carModel: .tiguan,
                      price: 0,
                      typeOfDrive: .rearDrive,
                      transmission: .automatic,
                      engineVolume: .mini)
        }
    }
    
    //MARK: -  actions
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if isFromAddButton {
            Storage.share.allCars.append(car)
        }
        print(car.manufacturer, car.model, car.price)
        self.dismiss(animated: true)
    }
    
    //MARK: -  private functions
    
    private func enterPrice() {
        let alertController = UIAlertController(title: "Enter price", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: "done", style: .default) { [unowned alertController] _ in
            let answer = alertController.textFields![0].text ?? "0"
            if let price = Int(answer) {
                self.car.price = price
                self.carSettingsTableView.reloadRows(at: [IndexPath(row: 0, section: 2)],
                                                     with: .none)
            }
        }
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
    
    private func changeCarSettings(_ indexPath: IndexPath, name: String) {
        switch indexPath.section {
        case 0:
            car.manufacturer = CarManufacturer(rawValue: name) ?? .volkswagen
        case 1:
            car.model = CarModel(rawValue: name) ?? .tiguan
        case 3:
            car.typeOfDrive = TypeOfDrive(rawValue: name) ?? .rearDrive
        case 4:
            car.transmission = Transmission(rawValue: name) ?? .manual
        case 5:
            car.engineVolume = EngineVolume(rawValue: name) ?? .mini
        default:
            print("out of parameters")
        }
    }
}

//MARK: - tableViewDataSource

extension CarSettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            //Количество производителей
        case 0:
            return CarManufacturer.allCases.count
            //Количество моделей
        case 1:
            return CarModel.allCases.count - 1 // Одна модель дефолтная
            //Цена
        case 2:
            return 1
            //Количество типов привода
        case 3:
            return TypeOfDrive.allCases.count
            //Количество типов коробки передач
        case 4:
            return Transmission.allCases.count
            //Количество объемов двигателя
        case 5:
            return EngineVolume.allCases.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        var textLabel = String()
        cell.accessoryType = .none
        switch indexPath.section {
        case 0:
            textLabel = CarManufacturer.allCases[indexPath.row].rawValue
            if car != nil && textLabel == car.manufacturer.rawValue {
                cell.accessoryType = .checkmark
                selectedIndexPath.append(indexPath)
            }
        case 1:
            textLabel = CarModel.allCases[indexPath.row].rawValue
            if car != nil && textLabel == car.model.rawValue {
                cell.accessoryType = .checkmark
                selectedIndexPath.append(indexPath)
            }
        case 2:
            textLabel = String(car?.price ?? 0)
        case 3:
            textLabel = TypeOfDrive.allCases[indexPath.row].rawValue
            if car != nil && textLabel == car.typeOfDrive.rawValue {
                cell.accessoryType = .checkmark
                selectedIndexPath.append(indexPath)
            }
        case 4:
            textLabel = Transmission.allCases[indexPath.row].rawValue
            if car != nil && textLabel == car.transmission.rawValue {
                cell.accessoryType = .checkmark
                selectedIndexPath.append(indexPath)
            }
        case 5:
            textLabel = EngineVolume.allCases[indexPath.row].rawValue
            if car != nil && textLabel == car.engineVolume.rawValue {
                cell.accessoryType = .checkmark
                selectedIndexPath.append(indexPath)
            }
        default:
            textLabel = ""
        }
        cell.textLabel?.text = textLabel
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Производители"
        case 1:
            return "Модели"
        case 2:
            return "Цена"
        case 3:
            return "Тип привода"
        case 4:
            return "Тип коробки передач"
        case 5:
            return "Объем двигателя"
        default:
            return ""
        }
    }
}

//MARK: - tableViewDelegate

extension CarSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if indexPath.section == 2 {
            enterPrice()
        } else {
            cell.accessoryType = .checkmark
            // Настройки, чтобы в каждой секции была только одна выделенная строка
            if !selectedIndexPath.contains(indexPath) {
                let selectedRowInSection = selectedIndexPath.filter { $0.section == indexPath.section }
                if !selectedRowInSection.isEmpty {
                    let selectedIndex = selectedRowInSection[0]
                    let cell = tableView.cellForRow(at: selectedIndex)
                    cell?.accessoryType = .none
                    let indexSelectedIndexPath = selectedIndexPath.firstIndex(of: selectedIndex) ?? 0
                    selectedIndexPath.remove(at: indexSelectedIndexPath)
                }
                selectedIndexPath.append(indexPath)
                changeCarSettings(indexPath, name: cell.textLabel?.text ?? "")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}


