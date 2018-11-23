//
//  UIViewController+CoreData.swift
//  MovileNext
//
//  Created by Matheus on 21/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum ContextSaveType {
    case saved
    case alreadyExists
    case errorSaving
    case errorRetrievingData
}

extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveCategory(_ categoryName: String, completion: @escaping(ContextSaveType) -> Void) {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let categories = try context.fetch(fetchRequest)
            if categories.contains(where: { $0.name == categoryName }) {
                completion(.alreadyExists)
            } else {
                let category = Category(context: self.context)
                category.name = categoryName
                do {
                    try self.context.save()
                    completion(.saved)
                } catch {
                    completion(.errorSaving)
                }
            }
        } catch {
            completion(.errorRetrievingData)
        }
    }
    
    func saveMovie(_ movie: Movie, completion: @escaping(ContextSaveType) -> Void) {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        do {
            let movies = try context.fetch(fetchRequest)
            if movies.contains(where: { $0.trackId == movie.trackId }) {
                completion(.alreadyExists)
            } else {
                do {
                    try self.context.save()
                    completion(.saved)
                } catch {
                    completion(.errorSaving)
                }
            }
        } catch {
            completion(.errorRetrievingData)
        }
    }
}
