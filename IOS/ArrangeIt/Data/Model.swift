//
//  Model.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 15.07.2020.
//

import Foundation
import Firebase

typealias UserID = String
typealias EventID = String
typealias PictureID = Int


struct User {
    internal init(id: UserID, name: String, image: PictureID? = nil, isAppUser: Bool, followedEvents: [EventID]) {
        self.id = id
        self.name = name
        self.image = image
        self.isAppUser = isAppUser
        self.followedEvents = followedEvents
    }
    
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
    private init(nowUser: User? = nil, cachedEvents: [EventID : Event], cachedUsers: [UserID : User], cachedPictures: [PictureID : String], networkPuller: NetworkPuller = NetworkPuller()) {
        self.nowUser = nowUser
        self.cachedEvents = cachedEvents
        self.cachedUsers = cachedUsers
        self.cachedPictures = cachedPictures
        self.networkPuller = networkPuller
    }
    
    
    static var shared: InternalStorage = {
        let instance = InternalStorage(cachedEvents: [:], cachedUsers: [:], cachedPictures: [:])
            return instance
        }()
    
    var nowUser: User?
    
    var cachedEvents: [EventID:Event]
    var cachedUsers: [UserID:User]
    var cachedPictures: [PictureID:String]
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
    
    func getUserByID(ID userID: UserID) -> User? {
        if let cachedUser = cachedUsers[userID] {
            return cachedUser
        } else if let downloadedUser = networkPuller.getUserByID(ID: userID) {
            return downloadedUser
        } else {
            return nil
        }
    }
    
}

struct NetworkPusher {
    
    static var shared: NetworkPuller {
        let instance = NetworkPuller()
        return instance
    }
    let db = Firestore.firestore()
    
    func sendNewEvent(id: EventID, name: String, eventBeginDate: Date, eventEndDate: Date, place: (Double, Double), creatingDate: Date? = nil, owner: UserID, description: String? = nil, cover: PictureID? = nil, imageGallery: [PictureID]? = nil, willGoUsers: [UserID], mayGoUsers: [UserID]) {
        var ref: DocumentReference? = db.collection("events").addDocument(data: [
            "id": id,
            "name" : name,
            "eventBeginDate" : eventBeginDate,
            "eventEndDate" : eventEndDate,
            "place" : place,
            "creatingDate" : creatingDate?,
            "owner" : owner,
            "description" : description?,
            "cover" : cover!,
            "imageGallery" : imageGallery?,
            "willGoUsers" : willGoUsers,
            "mayGoUsers" : mayGoUsers,
        ]) {
            mayError in
            if let error = mayError {
                print("error sending event. name: \(name), id: \(id)")
            } else {
                print("succesfully sent event. name: \(name), id: \(id)")
                InternalStorage.shared.cachedEvents[id] = Event(id: id, name: name, eventBeginDate: eventBeginDate, eventEndDate: eventEndDate, place: place, creatingDate: creatingDate, owner: owner, description: description, cover: cover, imageGallery: imageGallery, willGoUsers: willGoUsers, mayGoUsers: mayGoUsers)
            }
        }
    }
    
}



//Тестовое пполучение мероприятия
func getEvent(){
    //let events : [Event]
    db.collection("events").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
                
                print("\(document.documentID) => \(document.data())")
            }
        }
    }
    //return events
}




//

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
        
//        return Event(id: "5", name: "Вписка", eventBeginDate: Date(), eventEndDate: Date().addingTimeInterval(3600), place: (54.3, 55.1), owner: "1", willGoUsers: ["1", "4"], mayGoUsers: ["5"])
    }
    
    func getUserByID(ID userID: UserID) -> User? {
        if let downloadedUser = self.tryDownloadUser(ID: userID) {
            return downloadedUser
        } else {
            return nil
        }
    }
    
    func tryDownloadUser(ID userID: UserID) -> User? {
        //
        
//        return User(id: "5", name: "Саша", image: nil, isAppUser: false, followedEvents: ["3", "4", "5"])
    }
}


//var testevent_1 = Event(id: "1", name: "Футбольный матч", eventBeginDate: Date(), eventEndDate: Date(), place: (51.1, 31.1), owner: "1", willGoUsers: ["1", "2"], mayGoUsers: ["3"])
//
//var testevent_2 = Event(id: "2", name: "Встреча в баре", eventBeginDate: Date(), eventEndDate: Date(), place: (52.2, 32.2), owner: "2", willGoUsers: ["2"], mayGoUsers: ["3", "4"])
//
//var testevent_3 = Event(id: "3", name: "Мафия", eventBeginDate: Date(), eventEndDate: Date(), place: (53.3, 33.3), owner: "2", willGoUsers: ["1", "2", "3"], mayGoUsers: ["5"])
//
//var testevent_4 = Event(id: "4", name: "Обмен одеждой", eventBeginDate: Date(), eventEndDate: Date(), place: (54.4, 34.4), owner: "3", willGoUsers: ["3"], mayGoUsers: ["1", "2", "4", "5"])
//
//
//var testuser_1 = User(id: "1", name: "Артём", image: nil, isAppUser: true, followedEvents: ["1", "3", "4", "5"])
//var testuser_2 = User(id: "2", name: "Егор", image: nil, isAppUser: false, followedEvents: ["1", "2", "3", "4"])
//var testuser_3 = User(id: "3", name: "Илья", image: nil, isAppUser: false, followedEvents: ["1", "2", "3", "4"])
//var testuser_4 = User(id: "4", name: "Света", image: nil, isAppUser: false, followedEvents: ["2", "4", "5"])
//
//
//var testEverythingStorage = InternalStorage(nowUser: testuser_1, cachedEvents: ["1": testevent_1, "2": testevent_2, "3": testevent_3, "4": testevent_4], cachedUsers: ["1": testuser_1, "2": testuser_2, "3": testuser_3, "4": testuser_4], cachedPictures: [:])
