//
//  Helpers.swift
//  Cars1
//
//  Created by Екатерина Алексеева on 07.08.2023.
//

import Foundation

final class Car {
    var manufacturer: CarManufacturer
    var model: CarModel
    var price: Int
    var typeOfDrive: TypeOfDrive
    var transmission: Transmission
    var engineVolume: EngineVolume
    
    init(carManufacturer: CarManufacturer,
         carModel: CarModel,
         price: Int,
         typeOfDrive: TypeOfDrive,
         transmission: Transmission,
         engineVolume: EngineVolume) {
        
        self.manufacturer = carManufacturer
        self.model = carModel
        self.price = price
        self.typeOfDrive = typeOfDrive
        self.transmission = transmission
        self.engineVolume = engineVolume
    }
    
    class func loadCars() {
        let car1 = Car(carManufacturer: .volkswagen,
                       carModel: .tiguan,
                       price: 100,
                       typeOfDrive: .rearDrive,
                       transmission: .manual,
                       engineVolume: .mini)
        let car2 = Car(carManufacturer: .volkswagen,
                       carModel: .polo,
                       price: 10,
                       typeOfDrive: .fourWheelDrive,
                       transmission: .automatic,
                       engineVolume: .mid)
        let car3 = Car(carManufacturer: .volkswagen,
                       carModel: .passat,
                       price: 20,
                       typeOfDrive: .fourWheelDrive,
                       transmission: .automatic,
                       engineVolume: .micro)
        let car4 = Car(carManufacturer: .honda,
                       carModel: .accord,
                       price: 420,
                       typeOfDrive: .fourWheelDrive,
                       transmission: .manual,
                       engineVolume: .large)
        let car5 = Car(carManufacturer: .honda,
                       carModel: .civic,
                       price: 1,
                       typeOfDrive: .fourWheelDrive,
                       transmission: .manual,
                       engineVolume: .mid)
        let car6 = Car(carManufacturer: .honda,
                       carModel: .city,
                       price: 12,
                       typeOfDrive: .fourWheelDrive,
                       transmission: .manual,
                       engineVolume: .large)
        let car7 = Car(carManufacturer: .renault,
                       carModel: .logan,
                       price: 45,
                       typeOfDrive: .fourWheelDrive,
                       transmission: .manual,
                       engineVolume: .large)
        let car8 = Car(carManufacturer: .renault,
                       carModel: .megan,
                       price: 28,
                       typeOfDrive: .fourWheelDrive,
                       transmission: .manual,
                       engineVolume: .large)
        let car9 = Car(carManufacturer: .renault,
                       carModel: .sandero,
                       price: 93,
                       typeOfDrive: .fourWheelDrive,
                       transmission: .manual,
                       engineVolume: .large)
        let car10 = Car(carManufacturer: .renault,
                       carModel: .logan,
                       price: 56,
                       typeOfDrive: .fourWheelDrive,
                        transmission: .automatic,
                       engineVolume: .large)
        
        Storage.share.allCars.append(car1)
        Storage.share.allCars.append(car5)
        Storage.share.allCars.append(car3)
        Storage.share.allCars.append(car10)
        Storage.share.allCars.append(car4)
        Storage.share.allCars.append(car6)
        Storage.share.allCars.append(car7)
        Storage.share.allCars.append(car8)
        Storage.share.allCars.append(car2)
        Storage.share.allCars.append(car9)
    }
}

enum CarManufacturer: String, CaseIterable {
    case volkswagen = "volkswagen"
    case honda = "honda"
    case renault = "renault"
}

enum CarModel: String, CaseIterable {
    case tiguan = "tiguan"
    case passat = "passat"
    case polo = "polo"
    case accord = "accord"
    case civic = "civic"
    case city = "city"
    case logan = "logan"
    case megan = "megan"
    case sandero = "sandero"
    case undefinite = ""
}

enum TypeOfDrive: String, CaseIterable {
    case rearDrive = "rearDrive"
    case frontWheelDrive = "frontWheelDrive"
    case fourWheelDrive = "fourWheelDrive"
}

enum Transmission: String, CaseIterable {
    case manual = "manual"
    case automatic = "automatic"
}

enum EngineVolume: String, CaseIterable {
    case micro = "< 1.1 litres"
    case mini = "1,1 - 1,8 litres"
    case mid = "1,8 - 3,5 litres"
    case large = "3,5 - 5,0 litres"
}
