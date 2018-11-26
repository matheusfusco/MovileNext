//
//  ViewController.swift
//  MovileNext
//
//  Created by Matheus on 20/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchMovieViewController: UIViewController {

    var results: Observable<[MovieFromAPI]> = Observable.just([])
    var selectedMovie: Observable<MovieFromAPI> {
        return selectedMovieSubject.asObservable()
    }
    var selectedMovieSubject = PublishSubject<MovieFromAPI>()
    let disposeBag = DisposeBag()
    
    @IBOutlet var noFilmsView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = noFilmsView
        rxSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        selectedMovieSubject.onCompleted()
    }

    func rxSetup() {
        btClose.rx.tap.subscribe(onNext: { [weak self] in
            if let `self` = self {
                self.dismiss(animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
        
        results = searchBar.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[MovieFromAPI]> in
                if query.isEmpty {
                    return .just([])
                }
                return APIController.shared.search(query)
//                    .catchError({ (error) -> Observable<[MovieFromAPI]> in
//                        return Observable.just([])
//                    })
                    .catchErrorJustReturn([])
            }
            .observeOn(MainScheduler.instance)
        
        
        results
            .distinctUntilChanged({ (_, newResults) -> Bool in
                self.noFilmsView.isHidden = newResults.count > 0
                return false
            })
            .bind(to: tableView.rx.items(cellIdentifier: "MovieCell",
                                         cellType: SearchMovieTableViewCell.self)) { (_/*row*/, movie, cell) in
                                            
                cell.configure(movie: movie)
            }
            .disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            if let `self` = self {
                self.tableView.deselectRow(at: indexPath, animated: true)
                if let cell = self.tableView.cellForRow(at: indexPath) as? SearchMovieTableViewCell {
                    let selectedMovie = cell.movie
                    self.selectedMovieSubject.onNext(selectedMovie!)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }).disposed(by: disposeBag)
    }
}
