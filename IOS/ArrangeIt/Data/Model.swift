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
typealias PathToImage = String


struct User {
    internal init(id: UserID, name: String, image: PathToImage? = nil, isAppUser: Bool, willGoEvents: [EventID], invitedToEvents: [EventID]) {
        self.id = id
        self.name = name
        self.image = image
        self.isAppUser = isAppUser
        self.willGoEvents = willGoEvents
        self.invitedToEvents = invitedToEvents
    }
    
    var id: UserID
    var name: String
    var image: PathToImage?
    var isAppUser: Bool
    
    var willGoEvents: [EventID]
    var invitedToEvents: [EventID]
}

struct Event {
    internal init(id: EventID, name: String, eventBeginDate: Date, eventEndDate: Date, place: (Double, Double), creatingDate: Date? = nil, owner: UserID, description: String? = nil, cover: PathToImage? = nil, imageGallery: [PathToImage]? = nil, willGoUsers: [UserID], invitedUsers: [UserID]) {
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
        self.invitedUsers = invitedUsers
    }
    
    
    var id: EventID
    var name: String
    
    var eventBeginDate: Date
    var eventEndDate : Date
    var place: (Double, Double)
    var creatingDate: Date?
    
    var owner: UserID
    
    var description: String?
    var cover: PathToImage?
    var imageGallery : [PathToImage]?
    
    
    var willGoUsers: [UserID]
    var invitedUsers: [UserID]
}

// Singleton!
struct InternalStorage {
    static var shared: InternalStorage = {
        let instance = InternalStorage()
        return instance
    }()
    
    private init(nowUser: User? = nil, cachedEvents: [EventID : Event] = [:], cachedUsers: [UserID : User] = [:]) {
        self.nowUser = nowUser
        self.cachedEvents = cachedEvents
        self.cachedUsers = cachedUsers
    }
    
    
    
    var nowUser: User?
    
    var cachedEvents: [EventID:Event]
    var cachedUsers: [UserID:User]
    
    func cleanup() {
        InternalStorage.shared.cachedEvents = [:]
        InternalStorage.shared.cachedUsers = [:]
        InternalStorage.shared.nowUser = nil
    }
    
    func getAdministratedEventsByUser(userOpt: User?) -> [EventID]? {
        if let user = userOpt {
            var result: [EventID] = []
            for eventID in user.willGoEvents {
                if let got_event = self.getEventByID(ID: eventID) {
                    result.append(got_event.id)
                }
            }
            return result
        } else {
            return nil
        }
    }
    
    func getFeaturedEvents() -> [EventID]? {
        // TODO
        return nil
    }
    
    func getEventByID(ID eventID: EventID) -> Event? {
        if let cachedEvent = cachedEvents[eventID] {
            return cachedEvent
        } else if let downloadedEvent = NetworkPuller.shared.downloadEventByID(ID: eventID) {
            return downloadedEvent
        } else {
            return nil
        }
    }
    
    func getUserByID(ID userID: UserID) -> User? {
        if let cachedUser = cachedUsers[userID] {
            return cachedUser
        } else if let downloadedUser = NetworkPuller.shared.downloadUserByID(ID: userID) {
            return downloadedUser
        } else {
            return nil
        }
    }
    
}

// Singleton!
struct FirebaseDB {
    static var shared: FirebaseDB {
        let instance = FirebaseDB()
        return instance
    }
    
    let db = Firestore.firestore()
}

// Singleton!
struct NetworkPusher {
    static var shared: NetworkPusher {
        let instance = NetworkPusher()
        return instance
    }
    
    func sendNewEvent(event: Event) {
        let defaultData = "20.1.2020"
        var _: DocumentReference? = FirebaseDB.shared.db.collection("events").addDocument(data: [
            "id": event.id,
            "name" : event.name,
            "eventBeginDate" : event.eventBeginDate,
            "eventEndDate" : event.eventEndDate,
            "place" : event.place,
            "creatingDate" : event.creatingDate ?? defaultData,
            "owner" : event.owner,
            "description" : event.description ?? "",
            "cover" : event.cover ?? "",
            "imageGallery" : event.imageGallery ?? "",
            "willGoUsers" : event.willGoUsers,
            "invitedUsers" : event.invitedUsers,
        ]) {
            mayError in
            if let error = mayError {
                print("error sending event. error: \(error) name: \(event.name), id: \(event.id)")
            } else {
                print("succesfully sent event. name: \(event.name), id: \(event.id)")
                InternalStorage.shared.cachedEvents[event.id] =  event
            }
        }
    }
    
    func sendUpdateToEvent(ID eventID: EventID, newData: Event) {
        // TODO
    }
    
    func sendUpdateForCurrentUser(newName: String?, newPassword: String?, newImage: String?) {
        // TODO
    }
}

// Singleton!
struct NetworkPuller {
    static var shared: NetworkPuller {
        let instance = NetworkPuller()
        return instance
    }
    
    func downloadUserByID(ID userID: UserID) -> User? {
        // TODO
        
        // InternalStorage.shared.cachedUsers[downloadedUser.id] = downloadedUser
        let testuser_5 = User(id: "5", name: "Саша", image: nil, isAppUser: false, willGoEvents: [], invitedToEvents: [])
        return testuser_5
    }
    
    func downloadEventByID(ID eventID: EventID) -> Event? {
        // TODO
        
        // InternalStorage.shared.cachedEvents[downloadedEvent.id] = downloadedEvent
        let testevent_5 =  Event(id: "5", name: "Вписка", eventBeginDate: Date(), eventEndDate: Date().addingTimeInterval(3600), place: (54.3, 55.1), owner: "1", willGoUsers: [], invitedUsers: [])
        return testevent_5
    }
    
    func getNearestEventsByPlace(placeCoordinates: (Double, Double), radius: Int) -> [EventID] {
        // TODO
        
        let testevent_4 = Event(id: "4", name: "Обмен одеждой", eventBeginDate: Date(), eventEndDate: Date().addingTimeInterval(360), place: (54.4, 34.4), owner: "3", willGoUsers: ["3"], invitedUsers: [])
        let testevent_5 =  Event(id: "5", name: "Вписка", eventBeginDate: Date(), eventEndDate: Date().addingTimeInterval(3600), place: (54.3, 55.1), owner: "1", willGoUsers: [], invitedUsers: [])
        return [testevent_5.id, testevent_4.id]
    }
    
    func fullDatabaseRefresh(appUserID: UserID) {
        // TODO
        
        // InternalStorage.cleanup()
        // for event in downloadedEvents {
        //     InternalStorage.shared.cachedEvents[event.id] = event
        // }
        // for user in downloadedUsers {
        //     InternalStorage.shared.cachedUsers[user.id] = user
        // }
        // for picture in downloadedPictures {
        //     *добавить в хранилище реальных файлов картинок*
        //     InternalStorage.shared.cachedPictures[picture.id] = picture
        // }
    }
}
//Тестовое получение мероприятия
//func getEvent(){
//    //let events : [Event]
//    db.collection("events").getDocuments() { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//            for document in querySnapshot!.documents {
//
//                print("\(document.documentID) => \(document.data())")
//            }
//        }
//    }
//    //return events
//}




// ТЕСТОВЫЕ ДАННЫЕ
//var testevent_5 =  Event(id: "5", name: "Вписка", eventBeginDate: Date(), eventEndDate: Date().addingTimeInterval(3600), place: (54.3, 55.1), owner: "1", willGoUsers: ["1", "4"], mayGoUsers: ["5"])
//var testuser_5 = User(id: "5", name: "Саша", image: nil, isAppUser: false, followedEvents: ["3", "4", "5"])


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
