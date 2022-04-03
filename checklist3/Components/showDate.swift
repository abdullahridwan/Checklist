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
    @Binding var datePressed: Date
    var body: some View {
        VStack {
            Text(convertDateFormatter(date: date, format: "EEEEE"))
            Text(convertDateFormatter(date: date, format: "dd"))
            DisplayDate(progress: 0.3)
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
}

struct showDate_Previews: PreviewProvider {
    static var previews: some View {
        showDate(date: Date(), datePressed: .constant(Date()))
    }
}
