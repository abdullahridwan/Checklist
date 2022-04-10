//
//  showDate.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/1/22.
//

import SwiftUI

struct showDate: View {
    @State var isPressed: Bool = false
    @State var date: Date
    //@State var progress: Float
    @Binding var datePressed: Date
    @State var gvm: GeneralViewModel = GeneralViewModel()
    var body: some View {
        VStack {
            Text(convertDateFormatter(date: date, format: "EEEEE"))
            Text(convertDateFormatter(date: date, format: "dd"))
            DisplayDate(progress: getProgressForDate())
        }
        .onTapGesture {
            datePressed = date
        }
        .padding(.all, 10)
        .background(isEqualTo(date1: date, date2: datePressed) ? Color.purple.opacity(0.15) : Color.white)
        .clipShape(Capsule())

        
    }
    
    
    func convertDateFormatter(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        return dateFormatter.string(from: date)
    }
    
    func isEqualTo(date1: Date, date2: Date) -> Bool {
        return convertDateFormatter(date: date1, format: "YYYY MM dd") ==         convertDateFormatter(date: date2, format: "YYYY MM dd")
    }
    func getProgressForDate() -> Float {
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
}

struct showDate_Previews: PreviewProvider {
    static var previews: some View {
        showDate(date: Date(), datePressed: .constant(Date()), gvm: GeneralViewModel())
    }
}
