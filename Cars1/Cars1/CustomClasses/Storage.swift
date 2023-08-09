//
//  Storage.swift
//  Cars1
//
//  Created by Екатерина Алексеева on 08.08.2023.
//

import Foundation

// Синглтон для хранения данных

final class Storage: NSObject {
    static let share = Storage()
    var allCars: [Car] = []
    
    private override init() {
        super.init()
    }
}
