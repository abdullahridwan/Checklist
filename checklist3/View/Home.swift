//
//  Home.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/2/22.
//

import SwiftUI

struct Home: View {
    @StateObject var hvm: HomeViewModel = HomeViewModel()
    var body: some View {
        NavigationView{
            ZStack {
                Color("Background").edgesIgnoringSafeArea(.all)
                ListOfItems(items: $hvm.items)
                .navigationTitle("Today's List")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button(action: {
                            hvm.items.append(TaskAndStatus(task: "", completion: false))
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(CalendarViewModel())
    }
}
