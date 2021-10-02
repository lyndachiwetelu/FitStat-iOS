//
//  CoreDataManager.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 02.10.21.
//

import Foundation
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FitStat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    mutating func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    mutating func fetchFoods() -> [Food]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Food>(entityName: "Food")
        do {
            let logs = try context.fetch(fetchRequest)
            return logs
        } catch {
            print("Error fetching: \(String(describing: error))")
            return nil
        }
    }
    
    mutating func fetchSleeps() -> [Sleep]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Sleep>(entityName: "Sleep")
        do {
            let logs = try context.fetch(fetchRequest)
            return logs
        } catch {
            print("Error fetching: \(String(describing: error))")
            return nil
        }
    }
    
    mutating func fetchMoods() -> [Mood]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Mood>(entityName: "Mood")
        do {
            let logs = try context.fetch(fetchRequest)
            return logs
        } catch {
            print("Error fetching: \(String(describing: error))")
            return nil
        }
    }

}
