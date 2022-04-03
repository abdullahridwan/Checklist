//
//  HomeViewModel.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/2/22.
//

import Foundation


class HomeViewModel: ObservableObject{
    @Published var items: [TaskAndStatus] = [TaskAndStatus]()
    
    init(){
        //Get Values from a date from CoreDataLayer
        items = [
            TaskAndStatus(task: "Water", completion: false),
            TaskAndStatus(task: "Protein", completion: false),
        ]
    }
}
