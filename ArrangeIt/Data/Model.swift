//
//  Model.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 15.07.2020.
//

import Foundation
import FirebaseStorage
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth

typealias UserID = String
typealias EventID = String
typealias PathToImage = String



let testEventsList = ["1": Event(id: "1", name: "Футбол во дворе", eventBeginDate: Date().addingTimeInterval(60), eventEndDate: Date().addingTimeInterval(3660), place: [55.773863, 37.679636], owner: "1", willGoUsers: ["1", "2", "3"], invitedUsers: []), "2": Event(id: "2", name: "Покер", eventBeginDate: Date().addingTimeInterval(3600), eventEndDate: Date().addingTimeInterval(7200), place: [55.810127, 37.652739], owner: "1", willGoUsers: ["1", "2", "3", "4", "5", "6"], invitedUsers: ["7", "8", "9"]), "3": Event(id: "3", name: "Встреча одноклассников", eventBeginDate: Date().addingTimeInterval(10000), eventEndDate: Date().addingTimeInterval(15000), place: [55.794207, 37.582787], owner: "1", willGoUsers: ["1", "2", "3", "4"], invitedUsers: ["5", "6"])]

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
    internal init(id: EventID, name: String, eventBeginDate: Date, eventEndDate: Date, place: [Double], creatingDate: Date? = nil, owner: UserID, description: String? = nil, cover: PathToImage? = nil, imageGallery: [PathToImage]? = nil, willGoUsers: [UserID], invitedUsers: [UserID]) {
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
    var place: [Double]
    var creatingDate: Date?
    
    var owner: UserID
    
    var description: String?
    var cover: PathToImage?
    var imageGallery : [PathToImage]?
    
    
    var willGoUsers: [UserID]
    var invitedUsers: [UserID]
}

struct Saver {
    static var userSaved: User? = User(id: "-19", name: "-19", isAppUser: false, willGoEvents: [], invitedToEvents: [])
}


struct FirebaseCover {
    
    static var shared: FirebaseCover = {
        var instance = FirebaseCover()
        return instance
    }()
    
    var ref = Database.database().reference()
    let fireBase = Firestore.firestore()
    private init() {
        
    }
    
    func getEventByID(_ id: EventID) -> Event? {
        var event: Event? = Event(id: id, name: "-1", eventBeginDate: Date(), eventEndDate: Date(), place: [], owner: "-1", willGoUsers: [], invitedUsers: [])
        ref.child("events").child(id).observeSingleEvent(of: .value, with: { (dataSnapshot) in
            let value = dataSnapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            let willGoUsers = value?["willGoUsers"] as? NSMutableArray ?? [""]
            let invitedUsers = value?["invitedUsers"] as? NSMutableArray
            let eventBeginDate = value?["eventBeginDate"] as? Timestamp
            let eventEndDate = value?["eventEndDate"] as? Timestamp
            let place = value?["place"] as? [NSNumber]
            event?.id = id
            event?.name = username
            event?.willGoUsers = (willGoUsers as? [UserID]) ?? []
            event?.invitedUsers = (invitedUsers as? [UserID]) ?? []
            event?.eventBeginDate = eventBeginDate?.dateValue() ?? Date()
            event?.eventEndDate = eventEndDate?.dateValue() ?? Date()
            event?.place = (place as? [Double]) ?? [0.0, 0.0]
        }) {
            (error) in
            event = nil
        }
        return event
    }
    
    func getUserByID(_ id: UserID) -> User? {
//        var user: User? = User(id: "-3", name: "-3", isAppUser: false, willGoEvents: [], invitedToEvents: [])
        FirebaseCover.shared.ref.child("users").child(id).observeSingleEvent(of: .value, with: { (dataSnapshot) in
            let value = dataSnapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            let userInvites = value?["invitedToEvents"] as? NSMutableArray ?? []
            let userEvents = value?["willGoEvents"] as? NSMutableArray ?? []
            Saver.userSaved?.id = id
            Saver.userSaved?.name = username
            Saver.userSaved?.willGoEvents = (userEvents as? [EventID]) ?? []
            Saver.userSaved?.invitedToEvents = (userInvites as? [EventID]) ?? []
        }) {
            (error) in
            Saver.userSaved = nil
        }
        return Saver.userSaved
    }
    
    func getUserEvents(_ id: UserID) -> [Event]? {
        let user = FirebaseCover.shared.getUserByID(id)
        var result: [Event]? = nil
        let tmp: [EventID]? = user?.willGoEvents
        if let tmp = tmp {
            result = []
            for eventID in tmp {
                if let event = FirebaseCover.shared.getEventByID(eventID) {
                    result?.append(event)
                }
            }
        }
        return result
    }
    
    func sendNewEvent(_ newEvent: Event) -> Bool {
        var result: Bool = false
        FirebaseCover.shared.fireBase.collection("events").document(newEvent.name).setData([
            "description": newEvent.description ?? " ",
            "place" : newEvent.place,
            "eventBeginDate" : Timestamp(date : newEvent.creatingDate ?? Date()),
            "eventEndDate" : Timestamp( date : newEvent.eventEndDate),
            "cover": newEvent.cover ?? " ",
            "imageGallery" : [],
            "willGoUsers" : newEvent.willGoUsers,
            "invitedUsers" : newEvent.invitedUsers
        ]) { err in
            if let _ = err {
                result = false
            } else {
                result = true
            }
        }
        return result
    }
    
    func sendEventUpdate(_ newEvent: Event) -> Bool {
        var result: Bool = false
        let eventRef = FirebaseCover.shared.fireBase.collection("events").document(newEvent.name)
        eventRef.updateData([
            "description": newEvent.description ?? " ",
            "place" : newEvent.place,
            "eventBeginDate" : Timestamp(date : newEvent.creatingDate ?? Date()),
            "eventEndDate" : Timestamp(date : newEvent.eventEndDate) ,
            "cover": newEvent.cover ?? " " ,
            "imageGallery" : [],
            "willGoUsers" : newEvent.willGoUsers,
            "invitedUsers" : newEvent.invitedUsers
        ]){ err in
            if let _ = err {
                result = false
            } else {
                result = true
            }
            
        }
        return result
    }
    
    func getNowUser() -> User? {
        let user = Auth.auth().currentUser
        if let user = user {
            var dw = FirebaseCover.shared.getUserByID(user.uid as UserID)
            print("dw: \(dw)")
            dw?.isAppUser = true
            return Saver.userSaved
        } else {
            return nil
        }
    }
}
//    func save() {
//            fireBase.collection("events").document(self.name).setData([
//                "description": self.description ?? " ",
//                "place" : self.place,
//                "eventBeginDate" : Timestamp( date : self.creatingDate ?? Date()),
//                "eventEndDate" : Timestamp( date : self.eventEndDate),
//                "cover": self.cover ?? " ",
//                "imageGallery" : self.imageGallery ?? [""],
//                "willGoUsers" : self.willGoUsers,
//                "invitedUsers" : self.invitedUsers
//            ]) { err in
//                if let err = err {
//                    print("Error writing document: \(err)")
//                } else {
//                    print("Document successfully written!")
//                }
//            }
//        }
//    func update(id: EventID, name: String, eventBeginDate: Date, eventEndDate: Date, place: [Double], creatingDate: Date? = nil, owner: UserID, description: String? = nil, cover: PathToImage? = nil, imageGallery: [PathToImage]? = nil, willGoUsers: [UserID], invitedUsers: [UserID]){
//        let eventRef = fireBase.collection("events").document(name)
//
//        eventRef.updateData([
//            "description": description ?? " ",
//            "place" : place,
//            "eventBeginDate" : Timestamp( date : creatingDate ?? Date()),
//            "eventEndDate" : Timestamp( date : eventEndDate) ,
//            "cover": cover ?? " " ,
//            "imageGallery" : self.imageGallery  ?? [""],
//            "willGoUsers" : willGoUsers,
//            "invitedUsers" : invitedUsers
//        ]){ err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//
//        }
//    }
//}
//
