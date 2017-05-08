//
//  ToDoItemTests.swift
//  ToDo
//
//  Created by Liem Vo on 5/7/17.
//  Copyright © 2017 Cyberbot. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {
    func test_Init_WhenGiventTitle_SetTitle() {
        let input = "Test tile"
        let item = ToDoItem(title: input)
        
        XCTAssertEqual(item.title, input, "should set title")
    }
    
    func test_Init_WhenGivenDescription_SetDescription() {
        let input = "Bar"
        let item = ToDoItem(title: "", itemDescription: input)
        
        XCTAssertEqual(item.itemDescription, input, "should set descrpition")
    }
    
    func test_Init_WhenGivenTimestamp_SetTimestamp() {
        let input: TimeInterval = 0.0
        let item = ToDoItem(title: "", timestamp: input)
        
        XCTAssertEqual(item.timestamp, input, "should set timestamp")
    }
    
    func test_Init_WhenGivenLocation_SetLocation() {
        let location = Location(name: "Foo")
        let item = ToDoItem(title: "", location: location)
        
        XCTAssertEqual(item.location?.name, location.name, "should set location")
    }
    
    func test_EqualItems_AreEqual() {
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Foo")
        
        XCTAssertEqual(first, second)
    }
    
    func test_EqualItems_WhenLocationDiffers_AreNotEqual() {
        let first = ToDoItem(title: "Foo", location: Location(name: "Foo"))
        let second = ToDoItem(title: "Foo", location: Location(name: "Bar"))
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_EqualItems_WhenOnlyOneHasLocation_AreNotEqual() {
        var first = ToDoItem(title: "Foo", location: Location(name: "Foo"))
        var second = ToDoItem(title: "Foo", location: nil)
        
        XCTAssertNotEqual(first, second)
        
        first = ToDoItem(title: "Foo", location: nil)
        second = ToDoItem(title: "Foo", location: Location(name: "Bar"))
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_EqualItems_WhenTimestampDiffers_AreNotEqual() {
        let first = ToDoItem(title: "Foo", timestamp: 0.0)
        let second = ToDoItem(title: "Foo", timestamp: 1.0)
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_EqualItems_WhenItemDescriptionDiffers_AreNotEqual() {
        let first = ToDoItem(title: "Foo", itemDescription: "Bar")
        let second = ToDoItem(title: "Foo", itemDescription: "Baz")
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_EqualItems_WhenTitleDiffers_AreNotEqual() {
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Bar")
        
        XCTAssertNotEqual(first, second)
    }
}

import CoreLocation
class LocationTests: XCTestCase {
    func test_Init_WhenGivenCoordinate_SetCoordinate() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "", coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func test_Init_WhenGivenName_SetName() {
        let input = "Foo"
        let location = Location(name: input)
        
        XCTAssertEqual(location.name, input)
    }
    
    func test_EqualLocations_AreEqual() {
        let first = Location(name: "Foo")
        let second = Location(name: "Foo")
        
        XCTAssertEqual(first, second)
    }
    
    func performNotEqualTestWith(firstName: String, secondName: String, firstLongLat: (Double, Double)? = nil, secondLongLat: (Double, Double)? = nil, line: UInt = #line ) {
        var firstCord: CLLocationCoordinate2D?
        var secondCord: CLLocationCoordinate2D?
        
        if let loc = firstLongLat {
            firstCord = CLLocationCoordinate2D(latitude: loc.1, longitude: loc.0)
        }
        
        if let loc = secondLongLat {
            secondCord = CLLocationCoordinate2D(latitude: loc.1, longitude: loc.0)
        }
        
        let first = Location(name: firstName, coordinate: firstCord)
        let second = Location(name: secondName, coordinate: secondCord)
        
        XCTAssertNotEqual(first, second, line: line)
    }
    
    func test_EqualLocations_WhenLatitudeDiffers_AreNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Foo", firstLongLat: (0, 1), secondLongLat: (0, 2))
    }
    
    func test_EqualLocations_WhenLongitudeDiffers_AreNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Foo", firstLongLat: (1, 0), secondLongLat: (2, 0))
    }
    
    func test_EqualLocations_WhenOnlyOneHasCoord_AreNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Foo", firstLongLat: (1, 0))
    }
    
    func test_EqualLocations_WhenNamesDiffers_AreNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Bar")
    }
}

class ItemManagerTests: XCTestCase {
    var sut:ItemManager!
    
    override func setUp() {
        super.setUp()
        sut = ItemManager()
    }
    
    func test_ToDoCount_Initially_IsZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }
    
    func test_DoneCount_Initially_IsZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_AddItem_IncreaseToDoCountToOne() {
        let item = ToDoItem(title: "Foo")
        
        sut.add(item)
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func test_AddItem_WhenItemAlreadyAdded_DoesNotIncreaseCount() {
        sut.add(ToDoItem(title: "Foo"))
        sut.add(ToDoItem(title: "Foo"))
        
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func test_ItemAt_AfterAddingAnItem_ReturnsThatItem() {
        let item = ToDoItem(title: "Foo")
        
        sut.add(item)
        let returnedItem = sut.item(at: 0)
        
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_CheckItemAt_ChangesCounts() {
        sut.add(ToDoItem(title: ""))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    func test_CheckItemAt_RemoveItemFromToDoItems() {
        let first = ToDoItem(title: "first")
        let second = ToDoItem(title: "second")
        
        sut.add(first)
        sut.add(second)
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.item(at: 0).title, second.title)
    }
    
    func test_DoneItemAt_ReturnsCheckedItem() {
        let item = ToDoItem(title: "Foo")
        sut.add(item)
        
        sut.checkItem(at: 0)
        let returnedItem = sut.doneItem(at: 0)
        
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_RemoveAll_ResultsInCountsBeZero() {
        sut.add(ToDoItem(title: "Foo"))
        sut.add(ToDoItem(title: "Bar"))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 1)
        XCTAssertEqual(sut.doneCount, 1)
        
        sut.removeAll()
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 0)
    }
}


