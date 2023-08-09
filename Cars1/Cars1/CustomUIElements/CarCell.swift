//
//  CarCell.swift
//  Cars1
//
//  Created by Екатерина Алексеева on 08.08.2023.
//

import UIKit

class CarCell: UITableViewCell {

    @IBOutlet weak var manufacturerAndModel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var typeOfDrive: UILabel!
    @IBOutlet weak var transmission: UILabel!
    @IBOutlet weak var engineVolume: UILabel!
    
    static let reuseIdentifier = "carCellReuseIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        manufacturerAndModel.text = ""
        price.text = ""
        typeOfDrive.text = ""
        transmission.text = ""
        engineVolume.text = ""
    }
}
