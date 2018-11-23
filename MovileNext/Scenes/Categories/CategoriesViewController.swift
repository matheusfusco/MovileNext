//
//  CategoriesViewController.swift
//  MovileNext
//
//  Created by Matheus on 22/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import CoreData

enum CategoryType {
    case add
    case edit
}

class CategoriesViewController: UIViewController {
    
    // MARK: - Properties
    var fetchedResultController: NSFetchedResultsController<Category>!
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet var noCategoriesView: UIView!
    
    // MARK: - Methods
    func loadCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch {
            showAlert(message: "Erro ao carregar as categorias!")
        }
    }
    
    func showAlert(type: CategoryType, category: Category?) {
        let title = (type == .add) ? "Adicionar" : "Atualizar"
        let alert = UIAlertController(title: "\(title) Categoria", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Nome da categoria"
            if let name = category?.name {
                textField.text = name
            }
        }
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action: UIAlertAction) in
            let category = category ?? Category(context: self.context)
            category.name = alert.textFields?.first?.text
            do {
                try self.context.save()
                self.loadCategories()
            } catch {
                self.showAlert(message: "Erro ao salvar a categoria!")
                print(error.localizedDescription)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        showAlert(type: .add, category: nil)
    }
}


// MARK: - UITableViewDelegate
extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = self.fetchedResultController.object(at: indexPath)
        let cell = tableView.cellForRow(at: indexPath)!
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            movie.addToCategories(category)
        } else {
            cell.accessoryType = .none
            movie.removeFromCategories(category)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Excluir") { (action: UITableViewRowAction, indexPath: IndexPath) in
            let category = self.fetchedResultController.object(at: indexPath)
            self.context.delete(category)
            do {
                try self.context.save()
            }
            catch {
                self.showAlert(message: "Erro ao excluir categoria!")
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Editar") { (action: UITableViewRowAction, indexPath: IndexPath) in
            let category = self.fetchedResultController.object(at: indexPath)
            tableView.setEditing(false, animated: true)
            self.showAlert(type: .edit, category: category)
        }
        editAction.backgroundColor = .blue
        return [editAction, deleteAction]
    }
}

// MARK: - UITableViewDelegate
extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedResultController.fetchedObjects?.count {
            tableView.backgroundView = (count == 0) ? noCategoriesView : nil
            return count
        } else {
            tableView.backgroundView = noCategoriesView
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let category = fetchedResultController.object(at: indexPath)
        cell.textLabel?.text = category.name
        cell.accessoryType = .none
        if movie != nil {
            if let categories = movie.categories, categories.contains(category) {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension CategoriesViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
