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
    
    var administratedEvents: [Event]
    var nonadministritedEvents: [Event]
}

struct Event {
    var id: EventID
    var name: String
    
    var happeningDate: Date
    var place: (Double, Double)
    var creatingDate: Date
    
    var owner: UserID
    
    var description: String
    var image: PictureID?
    
    var willGoUsers: [UserID]
    var mayGoUsers: [UserID]
}

struct UserStorage {
    var storage: [User]
    
}

User(id: "-1", name: "Test User", image: nil, isAppUser: true, administratedEvents: [Event(id: "1", name: "TestingEvent1", happeningDate: Date(), place: (56.7, 40.1), creatingDate: Date(), owner: "-1", description: "This is descritpion for 1 test event", image: nil, willGoUsers: ["-1", "2"], mayGoUsers: [])], nonadministritedEvents: [Event(id: "2", name: "TestingEvent2", happeningDate: Date(), place: (50.3, 43.5), creatingDate: Date(), owner: "2", description: "This is descritpion for 2 test event", image: nil, willGoUsers: [2], mayGoUsers: [])])
