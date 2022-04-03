//
//  ContentView.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/1/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            CalendarNavBar()
                .tabItem({
                    Label("History", systemImage: "pencil")
                })
            Home()
                .tabItem({
                    Label("Home", systemImage: "house")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
