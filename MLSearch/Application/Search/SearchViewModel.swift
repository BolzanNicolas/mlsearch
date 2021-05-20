//
//  SearchViewModel.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 18/05/2021.
//

import UIKit
import RxCocoa
import RxSwift

extension SearchTableViewController {
    
    final class ViewModel {
        
        private var disposeBag = DisposeBag()
        
        var history = BehaviorRelay<[String]?>(value: [])
        
        var searchBar: UISearchBar = {
            let searchView = UISearchBar()
            searchView.placeholder = "Que deseas buscar?"
            searchView.searchTextField.layer.cornerRadius = 18
            searchView.setPositionAdjustment(UIOffset(horizontal: 5, vertical: 0), for: .search)
            searchView.searchTextField.layer.masksToBounds = true
            searchView.searchTextPositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
            searchView.searchTextField.backgroundColor = .white
            searchView.setImage(#imageLiteral(resourceName: "ic_searchbar"), for: .search, state: .normal)
            searchView.searchTextField.leftView?.tintColor = #colorLiteral(red: 0.7803145051, green: 0.780446589, blue: 0.7802971005, alpha: 1)
            searchView.searchTextField.textColor = .label
            searchView.searchTextField.tintColor = UIColor(named: "AccentColor")!

            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
                .defaultTextAttributes = [.foregroundColor: UIColor.black,
                                          .font: UIFont.systemFont(ofSize: 13)]
            
            return searchView
        }()
        
        init() {
            history.accept(UserDefaults.standard.value(forKey: "history") as? [String])
            
            history.subscribe(onNext: { newHistory in
                UserDefaults.standard.setValue(newHistory, forKey: "history")
            }).disposed(by: disposeBag)
        }
        
    }
    
}
