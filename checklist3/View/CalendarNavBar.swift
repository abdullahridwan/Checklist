//
//  CalendarNavBar.swift
//  Checklist2
//
//  Created by Abdullah Ridwan on 4/1/22.
//

import SwiftUI

struct CalendarNavBar: View {
    @StateObject var cvm: CalendarViewModel = CalendarViewModel()
    @State var itemsChanged: Bool = false
    
    var sevenColumnGrid: [GridItem] = Array(repeating: .init(.flexible()), count: 7)


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
                    .padding(.horizontal)
                    
                    LazyVGrid(columns: sevenColumnGrid, spacing: 10){
                        ForEach(cvm.weekdays, id: \.self){dateObj in
                            showDate(date: dateObj, datePressed: $cvm.datePressed)
                        }
                    }
                    
                    ListOfItems(items: $cvm.items)
                    
                    Button(action: {
                        cvm.updateDateAndValue(date: cvm.datePressed, items: cvm.items)
                        cvm.originalItems = cvm.items
                        itemsChanged = cvm.isDiffBtwnItems()
                    }, label: {
                        Text("Save").foregroundColor(Color.white)
                    })
                    .padding()
                    .padding(.horizontal)
                    .background(itemsChanged == false ? Color.blue : Color.red)
                    .clipShape(Capsule())
                    
                    

                }
                .padding(.top, 20)
                .padding(.horizontal)
                .navigationTitle("This Weeks Items")
                .onAppear(perform: {
                    cvm.updateWeekdays()
                    cvm.updateItems()
                })
                .onChange(of: cvm.items, perform: {newItems in
                    itemsChanged = cvm.isDiffBtwnItems()
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
                            cvm.items.append(TaskAndStatus(task: "Write Something...", completion: false))
                            
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
