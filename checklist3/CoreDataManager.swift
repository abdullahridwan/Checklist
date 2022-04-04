//
//  CoreDataManager.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/3/22.
//

import Foundation
import CoreData


class CoreDataManager: ObservableObject{
    @Published var allDateDatums: [DateDatum] = [DateDatum]()
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private init() {
        persistentContainer = NSPersistentContainer(name: "Database")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize CD Stack \(error)")
            }
        }
        allDateDatums = getAllDateDatum()
    }
    

    
    func save(){
        do{
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
    }
    
    
    func getAllDateDatum() -> [DateDatum]{
        let request = NSFetchRequest<DateDatum >(entityName: "DateDatum")
        do{
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    
    func getTasksFromDateDatum(dateDatum: DateDatum) -> [TaskDatum]{
        return dateDatum.tasks?.allObjects as! [TaskDatum]
    }
    
    func createTaskDatum(newTD: TaskDatum){
        save()
    }
    func createDateDatum(newDD: DateDatum){
        save()
    }
    
    func updateTaskDatum(td: TaskDatum){}
    func updateDateDatum(){}
    
    func deleteTaskDatum(){}
    func deleteDateDatum(){}
    
    //Main Functionst
//    func save(){
//        do{
//            try viewContext.save()
//        } catch {
//            viewContext.rollback()
//        }
//    }
//    func getAllDates() -> [InfoModel]{
//        //make a request
//        let request = NSFetchRequest<InfoModel>(entityName: "InfoModel")
//        //execute request
//        do{
//            return try viewContext.fetch(request)
//        } catch {
//            return []
//        }
//    }
//    func updateToDo(t: InfoModel ){
//        save()
//    }
//
//    func deleteToDo(t: InfoModel){
//        viewContext.delete(t)
//        save()
//    }
}
