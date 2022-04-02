//
//  CalendarNavBar.swift
//  Checklist2
//
//  Created by Abdullah Ridwan on 4/1/22.
//

import SwiftUI

struct CalendarNavBar: View {
    @StateObject var cvm: CalendarViewModel = CalendarViewModel()
    var sevenColumnGrid: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
//    @State var counter: Int = 0
//    @State var datePressed: Date = Date()
//    @State var weekDays: [Date] = [Date]()
//    @State var items: [TaskAndStatus] = [TaskAndStatus]()

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background").edgesIgnoringSafeArea(.all)
                VStack {
                    HStack{
                        Button(action: {
                            cvm.updateScreen(change: .dec)
                        }, label: {
                            Image(systemName: "chevron.left")
                        })
                        Spacer()
                        Text(cvm.convertDateFormatter(date: cvm.datePressed, format:"MMMM YYYY"))
                        Spacer()
                        Button(action: {
                            cvm.updateScreen(change: .inc)
                        }, label: {
                            Image(systemName: "chevron.right")
                        })
                    }
                    
                    LazyVGrid(columns: sevenColumnGrid, spacing: 10){
                        ForEach(cvm.weekdays, id: \.self){dateObject in
                            showDate(date: dateObject, datePressed: $cvm.datePressed)
                        }
                    }
                    
                    List{
                        ForEach(0..<cvm.items.count, id:\.self){index in
                            TextField("Write an item...", text: $cvm.items[index].task)
                        }
                        .onMove { indexSet, offset in
                            cvm.items.move(fromOffsets: indexSet, toOffset: offset)
                            //should resave items in that order
                        }
                        .onDelete { indexSet in
                            cvm.items.remove(atOffsets: indexSet)
                            //resave items for that day?
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal)
                .navigationTitle("This Weeks Items")
                .onAppear(perform: {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                    cvm.updateWeekdays()
                    cvm.updateItems()
                })
                .onChange(of: cvm.datePressed, perform: {newDate in
                    cvm.updateItems()
                    cvm.updateWeekdays()
                })
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        Button(action: {
                            cvm.updateScreen(change: .reset)
                        }, label: {
                            Image(systemName: "house")
                        })
                    })
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button(action: {
                            cvm.items.append(TaskAndStatus(task: "", completion: false))
                        }, label: {Image(systemName: "plus")})
                    })
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        EditButton()
                    })
                })
            }
        }
        
        
        
        
        
        
    }
    

    


    
    
}

struct CalendarNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarNavBar()
    }
}
