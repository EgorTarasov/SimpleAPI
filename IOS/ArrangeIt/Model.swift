//
//  Model.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 15.07.2020.
//

import Foundation

typealias UserID = Int
typealias EventID = Int
typealias PictureID = Int

struct User {
    var id: UserID
    var name: String
    var image: PictureID?
    var isAppUser: Bool
    
    var followedEvents: [EventID]
}

struct Event {
    internal init(id: EventID, name: String, eventBeginDate: Date, eventEndDate: Date, place: (Double, Double), creatingDate: Date? = nil, owner: UserID, description: String? = nil, cover: PictureID? = nil, imageGallery: [PictureID]? = nil, willGoUsers: [UserID], mayGoUsers: [UserID]) {
        self.id = id
        self.name = name
        self.eventBeginDate = eventBeginDate
        self.eventEndDate = eventEndDate
        self.place = place
        self.creatingDate = creatingDate
        self.owner = owner
        self.description = description
        self.cover = cover
        self.imageGallery = imageGallery
        self.willGoUsers = willGoUsers
        self.mayGoUsers = mayGoUsers
    }
    
    
    var id: EventID
    var name: String
    
    var eventBeginDate: Date
    var eventEndDate : Date
    var place: (Double, Double)
    var creatingDate: Date?
    
    var owner: UserID
    
    var description: String?
    var cover: PictureID?
    var imageGallery : [PictureID]?
    
    
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
        
        return Event(id: 1, name: "Test Event1", eventBeginDate: Date(), eventEndDate: Date(), place: (54.3, 55.1), owner: 1, willGoUsers: [1, 2], mayGoUsers: [3])
    }
}
