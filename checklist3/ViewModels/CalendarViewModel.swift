//
//  CalendarViewModel.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/2/22.
//

import Foundation

struct TaskAndStatus: Hashable {
    var task: String
    var completion: Bool
}


class CalendarViewModel: ObservableObject{
    var counter: Int = 0
    let clvm: ChecklistViewModel = ChecklistViewModel()
    @Published var datePressed: Date = Date()
    @Published var weekdays: [Date] = [Date]()
    @Published var items: [TaskAndStatus] = [TaskAndStatus]()
    @Published var todaysItems: [TaskAndStatus] = [TaskAndStatus]()
    
    
    /// Use Date formatter on some Date Object
    /// - Parameters:
    ///   - date: Date
    ///   - format: String
    /// - Returns: String
    func convertDateFormatter(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        return dateFormatter.string(from: date)
    }
    
    /// Get the Days of the week for some given date.
    /// - Parameter date: Date
    /// - Returns: [Date]
    func getDaysForWeek(date: Date) -> [Date]{
        let calendar = Calendar.current
        let someDate = Calendar.current.date(byAdding: .weekOfYear, value: counter, to: Date())!
        let someDayOfWeek = calendar.component(.weekday, from: someDate)
        let someWeekDays = calendar.range(of: .weekday, in: .weekOfYear, for: someDate)!
        let someDays = (someWeekDays.lowerBound ..< someWeekDays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - someDayOfWeek, to: someDate) }
        return someDays
    }
    
    /// Get the items for the date that the user presses.
    /// - Parameter date: Date
    /// - Returns: [TaskAndStatus]
    func getItemsForDatePressed(date: Date) -> [TaskAndStatus]{
        //Get Values from a date from CoreDataLayer
        return clvm.getTasksFromDate(date: date)
//        return [
//            TaskAndStatus(task: convertDateFormatter(date: datePressed, format: "YYYY MM dd"), completion: true),
//            TaskAndStatus(task: "Water", completion: false),
//            TaskAndStatus(task: "Protein", completion: false)
//        ]
        
    }

    
    /// Get the Items for the Current Day and Display it on the Home Page
    func getTodaysItems(){
        todaysItems = getItemsForDatePressed(date: Date())
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
        items = getItemsForDatePressed(date: datePressed)
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
    func save(){
        clvm.createDateDatum(date: datePressed, tasks: items)
    }
    

}
