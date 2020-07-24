//
//  EventMenu.swift
//  ArrangeIt
//


import UIKit
import Firebase

class EventMenuViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var user = User()
        user.getCurrentUser(user: user)
        let id = Auth.auth().currentUser?.uid ?? "1"
        user = UsersStorage.shared.cacheId[id]!
        if user.name != "" {
            let eventsCollection = EventsCollection()
            eventsCollection.getWillEvents(userid: user.id)
            let invitesCollection = EventsCollection()
            invitesCollection.getInvitedEvents(userid: user.id)
            return 1 + eventsCollection.count + invitesCollection.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var user = User()
        user.getCurrentUser(user: user)
        let id = Auth.auth().currentUser?.uid ?? "1"
        print(UsersStorage.shared.cacheId)
        user = UsersStorage.shared.cacheId[id]!
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        if user.name != "" {
            let eventsCollection = EventsCollection()
            eventsCollection.getWillEvents(userid: user.id)
            let invitesCollection = EventsCollection()
            invitesCollection.getInvitedEvents(userid: user.id)
            if indexPath.row == 0 {
                cell.textLabel?.text = "Создать новое событие"
                return cell
            } else if indexPath.row - 1 < eventsCollection.count {
                cell.textLabel?.text = eventsCollection.storage[indexPath.row - 1].name
                return cell
            } else {
                cell.textLabel?.text = invitesCollection.storage[indexPath.row - eventsCollection.count - 1].name
                return cell
            }
        } else {
            cell.textLabel?.text = "Новое событие"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var user = User()
        user.getCurrentUser(user: user)
        let id = Auth.auth().currentUser?.uid
        if let tmp = UsersStorage.shared.cacheId[id ?? ""] {
            user = tmp
        }
        print("username:\(user.name)")
        if indexPath.row == 0 && user.name != "" {
            if let vc = storyboard?.instantiateViewController(identifier: "newEvent") as? NewEventViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if user.name != "" {
                let eventsCollection = EventsCollection()
                eventsCollection.getWillEvents(userid: user.id)
                let invitesCollection = EventsCollection()
                invitesCollection.getInvitedEvents(userid: user.id)
                if let vc = storyboard?.instantiateViewController(identifier: "eventDetail") as? EventDetailViewController {
                    if indexPath.row - 1 < eventsCollection.count {
                        vc.selectedEvent = eventsCollection.storage[indexPath.row - 1]
                    } else {
                        vc.selectedEvent = invitesCollection.storage[indexPath.row - eventsCollection.count - 1]
                    }
                }
            }
        }
    }
}

