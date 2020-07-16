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
    var nowUser: User
}
