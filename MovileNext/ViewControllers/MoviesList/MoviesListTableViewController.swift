//
//  MoviesListTableViewController.swift
//  MovileNext
//
//  Created by Matheus on 22/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import CoreData

class MoviesListTableViewController: UITableViewController {
    
    var fetchedResultController: NSFetchedResultsController<Movie>!
    
    @IBOutlet var noFilmsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController {
            vc.movie = fetchedResultController.object(at: tableView.indexPathForSelectedRow!)
        }
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 106
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func loadMovies() {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch {
            self.showAlert(message: Localization.errorLoadingMovie)
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedResultController.fetchedObjects?.count {
            tableView.backgroundView = (count == 0) ? noFilmsView : nil
            return count
        } else {
            tableView.backgroundView = noFilmsView
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell {
            let movie = fetchedResultController.object(at: indexPath)
            cell.configure(movie)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = fetchedResultController.object(at: indexPath)
            context.delete(movie)
            do {
                try context.save()
            } catch {
                showAlert(message: Localization.errorDeletingMovie)
            }
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension MoviesListTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
