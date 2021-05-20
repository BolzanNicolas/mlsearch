//
//  ItemHeaderTableViewCell.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 19/05/2021.
//

import UIKit

final class ItemHeaderTableViewCell: UITableViewCell {

    // MARK: - Life cycle -
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var freeShippingView: UIStackView!
    @IBOutlet weak var availableQuantityLabel: UILabel!
    
    // MARK: - Configuration -
    func configure(with item: MLItem) {
        itemImageView.kf.setImage(with: URL(string: item.thumbnail ?? ""), options: [.transition(.fade(0.3))])
        itemTitleLabel.text = item.title
        itemPriceLabel.text = "$ \(item.price ?? 0)"
        
        freeShippingView.isHidden = item.shipping?.freeShipping == false
        
        let availables = item.availableQuantity ?? 1
        availableQuantityLabel.text = "\(availables) disponible\(availables > 1 ? "s" : "")"
    }
}
