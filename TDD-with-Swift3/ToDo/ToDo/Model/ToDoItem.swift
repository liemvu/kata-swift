//
//  ToDoItem.swift
//  ToDo
//
//  Created by Liem Vo on 5/7/17.
//  Copyright © 2017 Cyberbot. All rights reserved.
//

import Foundation
struct ToDoItem : Equatable {
    let title: String
    let itemDescription: String?
    let timestamp: TimeInterval?
    let location: Location?
    init(title: String, itemDescription: String? = nil, timestamp: TimeInterval? = nil, location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
    
    public static func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        if lhs.title != rhs.title ||
            lhs.location != rhs.location ||
            lhs.timestamp != rhs.timestamp ||
            lhs.itemDescription != rhs.itemDescription {
            return false
        }
        return true
    }
}

import CoreLocation
struct Location : Equatable {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
    
    public static func ==(lhs: Location, rhs: Location) -> Bool {
        if lhs.coordinate?.latitude != rhs.coordinate?.latitude ||
            lhs.coordinate?.longitude != rhs.coordinate?.longitude ||
            lhs.name != rhs.name {
            return false
        }

        return true
    }
}

class ItemManager {
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    private var toDoItems:[ToDoItem] = []
    private var doneItems:[ToDoItem] = []
    
    func add(_ item: ToDoItem) {
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        }
    }
    
    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    func doneItem(at index: Int) -> ToDoItem{
        return doneItems[index]
    }
    
    func checkItem(at index: Int) {
        let item = toDoItems.remove(at: 0)
        doneItems.append(item)
    }

    func removeAll() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
}





