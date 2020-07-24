//
//  Model.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 15.07.2020.
//
import Foundation
import Firebase

typealias UserID = String
typealias PathToImage = String

let fireBase = Firestore.firestore()

class EventsCollection {
    var storage: [Event] = []
    var count: Int {
        return storage.count
    }
    func getWillEvents(userid: UserID) {
        let eventsRef = FirebaseCover.shared.fireBase.collection("users")
        let query = eventsRef.whereField("willGoEvents", arrayContains: "\(userid)")
        query.getDocuments() {
            (querySnapshot, err) in
            if err != nil {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let newEvent = Event()
                    let name = data["name"] as! String
                    let eventBeginDate = (data["eventBeginDate"] as! Timestamp).dateValue()
                    let eventEndDate = (data["eventEndDate"] as! Timestamp).dateValue()
                    let place = data["place"] as! [Double]
                    let owner = data["owner"] as! String
                    let willGoUsers = data["willGoUsers"] as! [String]
                    let invitedUsers = data["invitedUsers"] as! [String]
                    newEvent.update(name: name, eventBeginDate: eventBeginDate, eventEndDate: eventEndDate, place: place, owner: owner, description: nil, cover: nil, imageGallery: nil, willGoUsers: willGoUsers, invitedUsers: invitedUsers)
                    self.storage.append(newEvent)
                }
            }
        }
    }
    
    func getInvitedEvents(userid: UserID) {
        let eventsRef = FirebaseCover.shared.fireBase.collection("users")
        let query = eventsRef.whereField("invitedUsers", arrayContains: "\(userid)")
        query.getDocuments() {
            (querySnapshot, err) in
            if err != nil {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let newEvent = Event()
                    let name = data["name"] as! String
                    let eventBeginDate = (data["eventBeginDate"] as! Timestamp).dateValue()
                    let eventEndDate = (data["eventEndDate"] as! Timestamp).dateValue()
                    let place = data["place"] as! [Double]
                    let owner = data["owner"] as! String
                    let willGoUsers = data["willGoUsers"] as! [String]
                    let invitedUsers = data["invitedUsers"] as! [String]
                    newEvent.update(name: name, eventBeginDate: eventBeginDate, eventEndDate: eventEndDate, place: place, owner: owner, description: nil, cover: nil, imageGallery: nil, willGoUsers: willGoUsers, invitedUsers: invitedUsers)
                    self.storage.append(newEvent)
                }
            }
        }
    }
}

struct UsersStorage {
    static var shared: UsersStorage = {
        let instance = UsersStorage()
        return instance
    }()
    var cacheId: [UserID: User] = ["1":User()]
    var cacheEmail: [String: User] = ["":User()]
    var cacheEvent: [String: Event] = ["":Event()]
}

class User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    internal init(id: UserID, name: String, email: String, isAppUser: Bool) {
        self.id = id
        self.name = name
        self.isAppUser = isAppUser
        self.email = email
    }
    
    init() {
        self.id = ""
        self.name = ""
        self.email = ""
        self.isAppUser = false
    }
    
    var id: UserID
    var name: String
    var email: String
    var isAppUser: Bool
    
    func getCurrentUser(user: User) {
        let id = Auth.auth().currentUser?.uid ?? "1"
        user.getUserByID(id, user)
        user.isAppUser = true
        UsersStorage.shared.cacheId[id]?.isAppUser = true
    }
    
    func getUserByID(_ id: UserID, _ user: User) {
        FirebaseCover.shared.fireBase.collection("users").document(id).getDocument() {
            (document, error) in
            let data = document?.data()
            let username = data?["name"] as? String ?? ""
            let id = data?["id"] as? String ?? ""
            let email = data?["email"] as? String ?? ""
            UsersStorage.shared.cacheId[id] = User(id: id, name: username, email: email, isAppUser: false)
            user.name = username
            user.id = id
            user.email = email
        }
    }
    
    func getUserByEmail(_ email: String, user: User) {
        let eventsRef = FirebaseCover.shared.fireBase.collection("users")
        let query = eventsRef.whereField("email", isEqualTo: email)
        query.getDocuments() {
            (querySnapshot, error) in
            if error != nil {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let username = data["name"] as? String ?? ""
                    let id = data["id"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    UsersStorage.shared.cacheEmail[id] = User(id: id, name: username, email: email, isAppUser: false)
                    user.email = email
                    user.name = username
                    user.id = id
                }
            }
        }
    }
    
    func updateUsername(_ newName: String, user: User) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = newName
        changeRequest?.commitChanges(completion: {
            _ in
        })
        user.name = newName
    }
    
    func save() {
        fireBase.collection("users").document(self.id).setData([
            "email": self.email,
            "id": self.id,
            "name": self.name
        ]) { err in
            if let err = err {
                print("Error writing document: \(err.localizedDescription)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

class Event {
    internal init(name: String, eventBeginDate: Date, eventEndDate: Date, place: [Double], owner: UserID, description: String? = nil, cover: PathToImage? = nil, imageGallery: [PathToImage]? = nil, willGoUsers: [UserID], invitedUsers: [UserID]) {
        self.name = name
        self.eventBeginDate = eventBeginDate
        self.eventEndDate = eventEndDate
        self.place = place
        self.owner = owner
        self.description = description
        self.cover = cover
        self.imageGallery = imageGallery
        self.willGoUsers = willGoUsers
        self.invitedUsers = invitedUsers
    }
    
    init() {
        self.name = ""
        self.eventEndDate = Date()
        self.eventBeginDate = Date()
        self.place = [0.0, 0.0]
        self.owner = ""
        self.description = nil
        self.cover = nil
        self.imageGallery = nil
        self.willGoUsers = []
        self.invitedUsers = []
    }
    
    var name: String
    
    var eventBeginDate: Date
    var eventEndDate : Date
    var place: [Double]
    
    var owner: UserID
    
    var description: String?
    var cover: PathToImage?
    var imageGallery : [PathToImage]?
    
    var ref = Database.database().reference()
    
    var willGoUsers: [UserID]
    var invitedUsers: [UserID]
    
    func save() {
        fireBase.collection("events").document(self.name).setData([
            "description": self.description ?? " ",
            "place" : self.place,
            "eventBeginDate" : Timestamp(date: self.eventBeginDate),
            "eventEndDate" : Timestamp(date: self.eventEndDate),
            "cover": self.cover ?? "",
            "imageGallery" : self.imageGallery ?? [],
            "willGoUsers" : self.willGoUsers,
            "invitedUsers" : self.invitedUsers,
            "name" : self.name
        ]) { err in
            if let err = err {
                print("Error writing document: \(err.localizedDescription)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func update(name: String, eventBeginDate: Date, eventEndDate: Date, place: [Double], owner: UserID, description: String? = nil, cover: PathToImage? = nil, imageGallery: [PathToImage]? = nil, willGoUsers: [UserID], invitedUsers: [UserID]) {
        
        let eventRef = FirebaseCover.shared.fireBase.collection("events").document(name)
        
        eventRef.updateData([
            "description": description ?? " ",
            "place" : place,
            "eventBeginDate" : Timestamp( date : eventBeginDate ),
            "eventEndDate" : Timestamp( date : eventEndDate) ,
            "cover": cover ?? " " ,
            "imageGallery" : self.imageGallery  ?? [],
            "willGoUsers" : willGoUsers,
            "invitedUsers" : invitedUsers,
            "name": name
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
            
        }
    }
    
    func giveEventByName(_ name: String) {
        FirebaseCover.shared.fireBase.collection("events").document(name).getDocument() {
            (document, error) in
            let value = document?.data()
            let username = value?["name"] as? String ?? ""
            let willGoUsers = (value?["willGoUsers"] as? NSMutableArray ?? []) as? [String]
            let invitedUsers = (value?["invitedUsers"] as? NSMutableArray ?? []) as? [String]
            let eventBeginDate = (value?["eventBeginDate"] as? Timestamp)?.dateValue()
            let eventEndDate = (value?["eventEndDate"] as? Timestamp)?.dateValue()
            let place = value?["place"] as? [Double]
            let owner = value?["owner"] as? String
            UsersStorage.shared.cacheEvent[name] = Event(name: username, eventBeginDate: eventBeginDate ?? Date(timeIntervalSince1970: 0), eventEndDate: eventEndDate ?? Date(timeIntervalSince1970: 1000), place: place ?? [0.0, 0.0], owner: owner ?? "", willGoUsers: willGoUsers ?? [], invitedUsers: invitedUsers ?? [])
            self.name = username
            self.eventBeginDate = eventBeginDate ?? Date(timeIntervalSince1970: 0)
            self.eventEndDate = eventEndDate ?? Date(timeIntervalSince1970: 1000)
            self.place = place ?? [0.0, 0.0]
            self.owner = owner ?? ""
            self.willGoUsers = willGoUsers ?? []
            self.invitedUsers = invitedUsers ?? []
        }
    }
}

var eventSaved: Event?
var userSaved: User?


struct FirebaseCover {
    
    static var shared: FirebaseCover = {
        var instance = FirebaseCover()
        return instance
    }()
    
    var ref = Database.database().reference()
    let fireBase = Firestore.firestore()
    
    private init() {
        
    }
}
//let user = Auth.auth().currentUser
