//
//  ResultTableViewCell.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 18/05/2021.
//

import UIKit

final class ResultTableViewCell: UITableViewCell {

    // MARK: - Views -
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemBrandLabel: UILabel!
    
    // MARK: - Life cycle -
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }
    
    // MARK: - Configuration -
    func configure(with item: MLItem) {
        itemImageView.kf.setImage(with: URL(string: item.thumbnail ?? ""), options: [.transition(.fade(0.3))])
        itemTitleLabel.text = item.title
        itemPriceLabel.text = "$ \(item.price ?? 0)"
        itemBrandLabel.text = item.seller?.eshop?.nickname
    }
}
