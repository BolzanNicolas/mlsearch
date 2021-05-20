//
//  AttributeTableViewCell.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 19/05/2021.
//

import UIKit

final class AttributeTableViewCell: UITableViewCell {

    // MARK: - Views -
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    // MARK: - Configuration -
    func configure(with attribute: MLItem.Attribute) {
        nameLabel.text = attribute.name
        valueLabel.text = attribute.values?.first?.name ?? "-"
    }
    
}
