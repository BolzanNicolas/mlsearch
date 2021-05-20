//
//  ResultsTableViewController.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 18/05/2021.
//

import UIKit
import RxSwift

final class ResultsTableViewController: UITableViewController {
        
    // MARK: - Attributes -
    private var disposeBag = DisposeBag()
    private var searchText: String
    internal var items: [MLItem] = []
    private var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Init -
    init(searchText: String) {
        self.searchText = searchText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        title = searchText
        
        configureTableView()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.center = CGPoint(x: view.frame.size.width * 0.5,
                                           y: view.frame.size.height * 0.4);
        view.insertSubview(activityIndicator, at: 0)
        
        search()
    }

    // MARK: - Configuration -
    private func configureTableView() {
        let resultNib = UINib(nibName: String(describing: ResultTableViewCell.self), bundle: nil)
        tableView.register(resultNib,
                           forCellReuseIdentifier: String(describing: ResultTableViewCell.self))
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Actions -
    private func search() {
        APIClient.Search(keyword: searchText).dispatch()
            .subscribe(
                onSuccess: { [weak self] result in
                    self?.items = result.results ?? []
                    self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                },
                onFailure: { [weak self] error in
                    let alertVC = UIAlertController(title: "Upss.. algo salió mal", message: "Intentá nuevamente mas tarde", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self?.present(alertVC, animated: true)
                }, onDisposed: { [weak self] in
                    self?.activityIndicator.stopAnimating()
                })
            .disposed(by: disposeBag)
    }
    
}
