//
//  ItemDetailTableViewController.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 19/05/2021.
//

import UIKit

final class ItemDetailTableViewController: UITableViewController {

    // MARK: - Attributes -
    internal var item: MLItem
    
    enum Section: Int, CaseIterable {
        case header, attributes
    }
    
    // MARK: - Init -
    init(_ item: MLItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        title = item.seller?.eshop?.nickname
        configureTableView()
    }
    
    // MARK: - Configuration -
    private func configureTableView() {
        let headerNib = UINib(nibName: String(describing: ItemHeaderTableViewCell.self), bundle: nil)
        tableView.register(headerNib,
                           forCellReuseIdentifier: String(describing: ItemHeaderTableViewCell.self))
        
        let attributeNib = UINib(nibName: String(describing: AttributeTableViewCell.self), bundle: nil)
        tableView.register(attributeNib,
                           forCellReuseIdentifier: String(describing: AttributeTableViewCell.self))
        
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
    }


}
