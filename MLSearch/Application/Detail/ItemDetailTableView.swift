//
//  ItemDetailTableView.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 19/05/2021.
//

import UIKit

extension ItemDetailTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .header: return 1
        case .attributes: return item.attributes?.count ?? 0
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemHeaderTableViewCell.self)) as? ItemHeaderTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: item)
            return cell
            
        case .attributes:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AttributeTableViewCell.self)) as? AttributeTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: item.attributes![indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Section(rawValue: indexPath.section) {
        case .header: return 420
        case .attributes: return 44
        default: return 0
        }
    }
    
}
