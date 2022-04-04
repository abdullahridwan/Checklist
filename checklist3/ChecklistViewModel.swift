//
//  ChecklistViewModel.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/3/22.
//

import Foundation
import SwiftUI
import CoreData

enum GeneralError: Error {
    case EmptyArray
}


class ChecklistViewModel {
    
    
    
    
    /// Save To CoreData shared context
    func save(){
        CoreDataManager.shared.save()
    }
    
    
    /// Creates a new TaskDatum from TaskAndStatus
    /// - Parameter t: TaskAndStatus
    /// - Returns: TaskDatum Object
    func createTask(t: TaskAndStatus) -> TaskDatum {
        let newTaskDatum = TaskDatum(context: CoreDataManager.shared.viewContext)
        newTaskDatum.tid = UUID()
        newTaskDatum.name = t.task
        newTaskDatum.status = t.completion
        return newTaskDatum
        //save()
    }

    
    //Helper Functions
    func convertToTaskData(tasks: [TaskAndStatus]) -> [TaskDatum]{
        return tasks.map{ (TaskAndStatus) -> TaskDatum in
            let newTaskDatum = TaskDatum(context: CoreDataManager.shared.viewContext)
            newTaskDatum.tid = UUID()
            newTaskDatum.name = TaskAndStatus.task
            newTaskDatum.status = TaskAndStatus.completion
            return newTaskDatum
        }
    }
    
    func convertFromTaskData(tasks: [TaskDatum]) -> [TaskAndStatus]{
        return tasks.map{ (TaskDatum) -> TaskAndStatus in
            return TaskAndStatus(task: TaskDatum.name ?? "", completion: TaskDatum.status)
        }
    }
    

//    //gets Fate
//    func convertFromDateDatum(date: DateDatum) -> Date {
//        return date.date ?? Date()
//    }
    
    // Get existing DateDatum or create new one if it doesnt exist.
    func getDateDatum(date: Date) -> DateDatum {
        let fetchRequest: NSFetchRequest<DateDatum>
        fetchRequest = DateDatum.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "date == %@", date as CVarArg
        )

        // Get a reference to a NSManagedObjectContext
        let context = CoreDataManager.shared.viewContext

        // Perform the fetch request to get the objects
        // matching the predicate
        
        
        do{
            let objects = try context.fetch(fetchRequest)
            if !objects.isEmpty {
                print("DateDatum exists!")
                return objects.first!
            } else {
                throw GeneralError.EmptyArray
            }
        }catch{
            print("Making a new DateDatum...")
            let newDateDatum = DateDatum(context: CoreDataManager.shared.viewContext)
            newDateDatum.did = UUID()
            newDateDatum.date = date
            return newDateDatum
        }
    }
    
    func getTaskDataFromDate(date: Date) -> [TaskDatum] {
        let dateDatum = getDateDatum(date: date)
    
        
        //Then get [TaskDatum] DateDatum
        guard let taskData = dateDatum.tasks?.allObjects as? [TaskDatum] else {
            return []
        }
        return taskData
    }
    
    func createDateDatum(date: Date, tasks: [TaskAndStatus]){
        print("Creating Date Object...")
        //Convert Date to DateDatum
        let dateDatum = getDateDatum(date: date)
        print("Date Datum is", dateDatum)
        
        //Convert tasks to [TaskDatum]
        let taskData = convertToTaskData(tasks: tasks)
        print("Converting it to the task data", taskData)
        
        //Set [TaskDatum] to be associated with DateDatum
        dateDatum.tasks = NSSet(array: taskData)
        
        //Save to Core Data
        CoreDataManager.shared.save()
    }
    
    func getTasksFromDate(date: Date) -> [TaskAndStatus] {
        let taskData = getTaskDataFromDate(date: date)
        
        let taskAndStatuses = taskData.map{ (TaskDatum) -> TaskAndStatus in
            TaskAndStatus(task: TaskDatum.name ?? "", completion: TaskDatum.status )
        }
        
        return taskAndStatuses
        
    }
    
    
    
}
