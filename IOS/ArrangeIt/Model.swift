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

struct internalStorage {
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

