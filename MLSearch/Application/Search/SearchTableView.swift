//
//  SearchTableView.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 19/05/2021.
//

import UIKit

extension SearchTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.history.value?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchTableViewCell.self)) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let historyText = viewModel.history.value?[indexPath.row]
        let attributedHistory = NSMutableAttributedString()
            .normalText(historyText ?? "", size: 14)
            .boldText(viewModel.searchBar.text ?? "", size: 14)
        
        cell.searchLabel.attributedText = attributedHistory
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let searchText = viewModel.history.value?[indexPath.row] else { return }
        
        let resultVC = ResultsTableViewController(searchText: searchText)
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: nil,
                                        handler: { [weak self] _, _, _ in
                                            self?.removeHistory(at: indexPath)
                                        })
        delete.image = UIImage(systemName: "trash.fill")
        delete.backgroundColor = UIColor(named: "AccentColor")!
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            cell.contentView.alpha = 1
        })
    }
    
}
