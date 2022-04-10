//
//  CoreDataManager.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/9/22.
//

import Foundation
import CoreData


class CoreDataManager{
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private init() {
        persistentContainer = NSPersistentContainer(name: "DateAndTasks")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize CD Stack \(error)")
            }
        }
    }
    
    func getByID(tid: NSManagedObjectID) -> DateAndValues? {
        do{
            return try viewContext.existingObject(with: tid) as? DateAndValues
        } catch {
            return nil
        }
    }
    
    func save(){
        do{
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
    }
    func getAllDateAndValues() -> [DateAndValues]{
        let request = NSFetchRequest<DateAndValues>(entityName: "DateAndValues")
        do{
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    func updateToDo(t: DateAndValues){
        save()
    }
    func deleteToDo(t: DateAndValues){
        viewContext.delete(t)
        save()
    }
}
