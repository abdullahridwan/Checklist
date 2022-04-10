//
//  CalendarViewModel.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/2/22.
//

import Foundation





class CalendarViewModel: ObservableObject{
    var counter: Int = 0
    let format =  "YYYY MM dd"
    let gvm: GeneralViewModel = GeneralViewModel()
    @Published var datePressed: Date = Date()
    @Published var dateObjPressed: DateObj? = nil
    @Published var weekdays: [Date] = [Date]()
    @Published var originalItems: [TaskAndStatus] = [TaskAndStatus]()
    @Published var items: [TaskAndStatus] = [TaskAndStatus]()
    @Published var todaysItems: [TaskAndStatus] = [TaskAndStatus]()
    

    
    func save(){
        //clvm.save()
    }
    
    func isDiffBtwnItems() -> Bool {
        if originalItems.count != items.count {
            return true
        }
        
        for i in 0..<items.count {
            if items[i] != originalItems[i] {
                return true
            }
        }
        
        return false
    }
 
    func convertDateFormatter(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        return dateFormatter.string(from: date)
    }
    

    func getDaysForWeek(date: Date) -> [Date]{
        let calendar = Calendar.current
        let someDate = Calendar.current.date(byAdding: .weekOfYear, value: counter, to: Date())!
        let someDayOfWeek = calendar.component(.weekday, from: someDate)
        let someWeekDays = calendar.range(of: .weekday, in: .weekOfYear, for: someDate)!
        let someDays = (someWeekDays.lowerBound ..< someWeekDays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - someDayOfWeek, to: someDate) }
        return someDays
    }
    

    func getItemsForDate(date: Date) -> [TaskAndStatus]{
        //use string format to get the respective date object
        let dateObj = gvm.getDateObjectFromDate(date: date)
        
        //return the [TaskAndStatus] from date object
        return dateObj.tasks
//        return [
//            TaskAndStatus(task: convertDateFormatter(date: date, format: format), completion: false)
//        ]
    }

    func getProgressForDate(date: Date) -> Float {
        //get dateobject from date
        let dob = gvm.getDateObjectFromDate(date: date)
        
        //get progress from dateobject tasks.
        var count = 0
        for item in dob.tasks{
            if item.completion == true {
                count = count + 1
            }
        }
        
        if dob.tasks.count != 0 {
            print(Float(count / dob.tasks.count))
            return Float(count / dob.tasks.count)
        }else{
            return Float(0.0)
        }
    }
    
    
    /// Get the Items for the Current Day and Display it on the Home Page
    func getTodaysItems(){
        todaysItems = getItemsForDate(date: Date())
    }
    
    
    // UPDATE Published Values
    enum DateChanges {
        case backwardsOneWeek
        case forwardsOneWeek
        case today
    }

    func updateDatePressed(change: DateChanges){
        var dateComponent = DateComponents()
        switch change{
        case .today:
            datePressed = Date()
        case .backwardsOneWeek:
            dateComponent.day = -7
            datePressed = Calendar.current.date(byAdding: dateComponent, to: datePressed)!
        case .forwardsOneWeek:
            dateComponent.day = 7
            datePressed = Calendar.current.date(byAdding: dateComponent, to: datePressed)!
        }
    }
    
    func updateItems(){
        items = getItemsForDate(date: datePressed)
        originalItems = getItemsForDate(date: datePressed)
    }
    
    func updateDateAndValue(date: Date, items: [TaskAndStatus]){
        gvm.updateDateAndValue(date: date, items: items)
    }
    
    func updateWeekdays(){
        weekdays = getDaysForWeek(date: datePressed)
    }
    
    
    /// Going back and forth between weeks while update the datePressed, Days of the week shown, and the items for that day
    /// - Parameter change: String
    enum ScreenChanges {
        case inc
        case dec
        case reset
    }
    func updateScreen(change: ScreenChanges){
        switch change{
        case .inc:
            self.counter = self.counter + 1
            updateDatePressed(change: .forwardsOneWeek)
        case .dec:
            self.counter = self.counter - 1
            updateDatePressed(change: .backwardsOneWeek)
        case .reset:
            self.counter = 0
            updateDatePressed(change: .today)
        }
        updateWeekdays()
        updateItems()
    }
    
    /// Save the Items for that day onto the date Pressed
//    func save(){
//        clvm.saveTasksToDateObj(d: datePressed, tasks: items)
//    }
    
//    func getDateDatum2(d: DateObj) -> DateDatum {
//        let existingDateDatum = CoreDataManager.shared.getDateDatumByID(dateID: d.id)
//        if let existingDateDatum = existingDateDatum {
//            print("got existing date datum")
//            return existingDateDatum
//        }
//        print("Creating new date datum")
//        return CoreDataManager.shared.createDateDatum(dateID: d.date)
//    }
    

}
