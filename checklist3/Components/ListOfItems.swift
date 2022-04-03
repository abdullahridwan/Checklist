//
//  ListOfItems.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/2/22.
//

import SwiftUI

struct ListOfItems: View {
    @Binding var items: [TaskAndStatus]
    var body: some View {
        List{
            ForEach(0..<items.count, id:\.self){index in
//                TextField("Write an item...", text: $items[index].task)
                SeeText(text: $items[index].task)
            }
            .onMove { indexSet, offset in
                items.move(fromOffsets: indexSet, toOffset: offset)
                //should resave items in that order
            }
            .onDelete { indexSet in
                items.remove(atOffsets: indexSet)
                //resave items for that day?
            }
        }
        .onAppear(perform: {
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor.clear
        })
    }
}

struct ListOfItems_Previews: PreviewProvider {
    static var previews: some View {
        ListOfItems(items: .constant([
            TaskAndStatus(task: "Task 1", completion: true),
            TaskAndStatus(task: "Task 2", completion: true),
            TaskAndStatus(task: "Task 3", completion: false),
        ]))
    }
}
