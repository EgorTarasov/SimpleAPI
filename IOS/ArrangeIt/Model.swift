//
//  Model.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 15.07.2020.
//

import Foundation

typealias UserID = String
typealias EventID = String
typealias PictureID = String

struct User {
    var id: UserID
    var name: String
    var image: PictureID?
    var isAppUser: Bool
    
    var administratedEvents: [EventID]
    var nonadministritedEvents: [EventID]
}

struct Event {
    var id: EventID
    var name: String
    
    var happeningDate: Date
    var place: (Double, Double)
    var creatingDate: Date?
    
    var owner: UserID
    
    var description: String?
    var image: PictureID?
    
    var willGoUsers: [UserID]
    var mayGoUsers: [UserID]
}

struct InternalStorage {
    internal init(nowUser: User, cachedEvents: [EventID : Event], cachedUsers: [UserID : User], cachedPictures: [PictureID : String]) {
        self.nowUser = nowUser
        self.cachedEvents = cachedEvents
        self.cachedUsers = cachedUsers
        self.cachedPictures = cachedPictures
    }
    
    var nowUser: User
    
    var cachedEvents: [EventID: Event]
    var cachedUsers: [UserID: User]
    var cachedPictures: [PictureID: String]
    var networkPuller: NetworkPuller = NetworkPuller()
    
    func getEventByID(ID eventID: EventID) -> Event? {
        if let cachedEvent = cachedEvents[eventID] {
            return cachedEvent
        } else if let downloadedEvent = networkPuller.getEventByID(ID: eventID) {
            return downloadedEvent
        } else {
            return nil
        }
    }
    
}

struct NetworkPuller {
    func getEventByID(ID eventID: EventID) -> Event? {
        if let downloadedEvent = self.tryDownloadEvent(ID: eventID) {
            return downloadedEvent
        } else {
            return nil
        }
    }
    
    func tryDownloadEvent(ID eventID: EventID) -> Event? {
        //
        
        return Event(
            id: "3",
            name: "TestingEvent3",
            happeningDate: Date(),
            place: (51.2, 49.7),
            creatingDate: Date(),
            owner: "2",
            description: "This is descritpion for 3 test event",
            image: nil,
            willGoUsers: ["2"],
            mayGoUsers: []
    )
    }
}

var test_event1 = Event(
        id: "1",
        name: "TestingEvent1",
        happeningDate: Date(),
        place: (56.7, 40.1),
        creatingDate: Date(),
        owner: "1",
        description: "This is descritpion for 1 test event",
        image: nil,
        willGoUsers: ["1"],
        mayGoUsers: ["2"]
)
var test_event2 = Event(
        id: "2",
        name: "TestingEvent2",
        happeningDate: Date(),
        place: (50.6, 44.2),
        creatingDate: Date(),
        owner: "2",
        description: "This is descritpion for 2 test event",
        image: nil,
        willGoUsers: ["1", "2"],
        mayGoUsers: []
)
var test_User1 = User(
        id: "1",
        name: "Test1Name",
        image: nil,
        isAppUser: true,
        administratedEvents: [test_event1.id],
        nonadministritedEvents: [test_event2.id]
)
var test_User2 = User(
        id: "2",
        name: "Test2Name",
        image: nil,
        isAppUser: false,
        administratedEvents: [test_event2.id],
        nonadministritedEvents: [test_event1.id]
)
var testEverythingStorage = InternalStorage(
        nowUser: test_User1,
        cachedEvents: ["1": test_event1, "2": test_event2],
        cachedUsers: ["1": test_User1, "2": test_User2],
        cachedPictures: [:]
)
