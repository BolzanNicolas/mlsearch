//
//  SearchTableViewController.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 18/05/2021.
//

import UIKit
import RxSwift

final class SearchTableViewController: UITableViewController {
        
    // MARK: - Attributes -
    internal var viewModel = ViewModel()
    private var disposeBag = DisposeBag()
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        
        configureTableView()
        
        viewModel.searchBar.delegate = self
        
        viewModel.history.subscribe(
            onNext: { [weak self] _ in
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }).disposed(by: disposeBag)
        
        // Add searchbar dismiss button
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        viewModel.searchBar.searchTextField.inputAccessoryView = doneToolbar
    }
    
    // MARK: - Configuration -
    private func configureNavigationBar() {
        navigationItem.titleView = viewModel.searchBar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func configureTableView() {
        let searchNib = UINib(nibName: String(describing: SearchTableViewCell.self), bundle: nil)
        tableView.register(searchNib,
                           forCellReuseIdentifier: String(describing: SearchTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
    }
    
    // MARK: - Actions -
    @objc func doneButtonAction() {
        viewModel.searchBar.searchTextField.resignFirstResponder()
    }
    
    internal func removeHistory(at indexPath: IndexPath) {
        var newHistory = viewModel.history.value
        newHistory?.remove(at: indexPath.row)
        viewModel.history.accept(newHistory)
    }
    
}

// MARK: - UISearchBarDelegate -
extension SearchTableViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.searchTextField.resignFirstResponder()
        
        let newHistory = (viewModel.history.value ?? []) + [searchText]
        viewModel.history.accept(newHistory)
                
        let resultVC = ResultsTableViewController(searchText: searchText)
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
}
