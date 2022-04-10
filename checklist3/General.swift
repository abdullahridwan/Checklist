//
//  General.swift
//  checklist3
//
//  Created by Abdullah Ridwan on 4/9/22.
//

import Foundation
import CoreData

struct TaskAndStatus: Hashable {
    var task: String
    var completion: Bool
    //var id: NSManagedObjectID
}

struct DateObj: Hashable{
    var id: NSManagedObjectID
    var date: String
    var tasks: [TaskAndStatus]?
}
