//
//  GeneralViewModel.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/9/22.
//

import Foundation
import CoreData


struct DateObject{
    let id: NSManagedObjectID
    let dateString: String
    let tasks: [TaskAndStatus]
//    let status: String
//    let tasks: String
}

class GeneralViewModel {
    let format =  "YYYY MM dd"
    var dateAndIDs: [String : NSManagedObjectID] = [:]
    @Published var allDateObjects: [DateObject] = [DateObject]()
    
    // Convert Date to String
    func convertDateFormatter(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        return dateFormatter.string(from: date)
    }
    
    // Given item list: [TaskAndStatus], return string of tasks and completion
    func convertTaskAndStatuses(tasks: [TaskAndStatus]) -> (String, String){
        var taskNames: [String] = [String]()
        var statuses: [String] = [String]()
        for task in tasks{
            taskNames.append(task.task.trimmingCharacters(in: .whitespacesAndNewlines))
            statuses.append(task.completion == true ? "T" : "F")
        }
        return (taskNames.joined(separator: ","), statuses.joined(separator: ","))
    }
    
    // Given a coredata object, returns [TaskAndStatus]
    func getTaskAndStatusesFromString(tasks: String, statuses: String) -> [TaskAndStatus]{
        let tl = tasks.split(separator: ",")
        let sl = statuses.split(separator: ",")
        var ret: [TaskAndStatus] = [TaskAndStatus]()
        if tl.count == sl.count {
            for i in 0..<tl.count{
                ret.append(TaskAndStatus(task: String(tl[i]), completion: sl[i] == "T" ? true : false ))
            }
        }
        return ret
    }
    // Change Date to String
    
    // Get all DateAndValues
    func getAllDateAndValues(){
        allDateObjects = CoreDataManager.shared.getAllDateAndValues().map { (DateAndValues) -> DateObject in
            return DateObject(id: DateAndValues.objectID, dateString: DateAndValues.dateString ?? "", tasks: getTaskAndStatusesFromString(tasks: DateAndValues.tasks ?? "", statuses: DateAndValues.status ?? ""))
        }
    }
    
    
    // Create a DateAndValue from the date Pressed
    func createDateAndValueFromDatePressed(date: Date, items: [TaskAndStatus]){
        // Given a date, and items: [TaskAndStatus]
        // Turn date into a string using the converter
        let dateString = convertDateFormatter(date: date, format: format)
        
        // Use second function to get a string of completions and tasks
        let response = convertTaskAndStatuses(tasks: items)
        
        // Create DateAndValue from that date string, string of completion, and string of tasks
        let dav = DateAndValues(context: CoreDataManager.shared.viewContext)
        dav.dateString = dateString
        dav.tasks = response.0
        dav.status = response.1
        
        
        // Save it to Context
        CoreDataManager.shared.save()
        
        getAllDateAndValues()
    }
    
    // Get a DateAndValue given Date
    func getDateObjectFromDate(date: Date) -> DateObject{
        // turn date into string
        let dateString = convertDateFormatter(date: date, format: format)
        
        // then search thru the [allDateAndValues] and find the string thing
        for dav in allDateObjects {
            let val = dav.dateString
            if dateString == val {
                return dav
            }
        }
        
        // if it doesnt exist, then make a new one.
        createDateAndValueFromDatePressed(date: date, items: [])
        return allDateObjects[allDateObjects.count - 1]
    }
    
    // Update a DateAndValue
    func updateDateAndValue(date: Date, items: [TaskAndStatus]){
        //turn date to string
        //find respective dateObject
        
        let dateObject = getDateObjectFromDate(date: date)
        //get id from object
        
        //use object to get dateandvalue by id (fxn)
        let dav = CoreDataManager.shared.getByID(tid: dateObject.id)
        let response = convertTaskAndStatuses(tasks: items)
        
        //update values
        dav?.tasks = response.0
        dav?.status = response.1
        
        //save to context
        CoreDataManager.shared.save()
        
        getAllDateAndValues()
    }
    // Delete a DateAndValue
}
