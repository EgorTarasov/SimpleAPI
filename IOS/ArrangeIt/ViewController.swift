//
//  ViewController.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 15.07.2020.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Создание тестового пользователя и мероприятия
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
        var testEverythingStorage = internalStorage(
                nowUser: test_User1,
                cachedEvents: ["1": test_event1, "2": test_event2],
                cachedUsers: ["1": test_User1, "2": test_User2],
                cachedPictures: [:]
        )
    }
}

class AccountMenuView: UITableViewController {
    var nowUser: User = testEverythingStorage.getNowUser()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Отвечает за количество строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + nowUser.administratedEvents.count
    }
    
    // Отвечает за то, куда перейдет пользователь после тапа по строчке
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "MyAccountItem") as? DetailedAccountView {
                vc.selectedUser = nowUser
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "AdministratedEventItem") as? DetailedEventView {
                vc.selectedEvent = everythingStorage.getEventByID(nowUser.administratedEvents[indexPath.row - 1]).name
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // Отвечает за то, какой контент находится на строчке
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyAccountItem", for: indexPath)
            cell.textLabel?.text = nowUser.name
            cell.imageView?.image = UIImage(systemName: "person")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdministratedEventsItem", for: indexPath)
            cell.textLabel?.text = everythingStorage.getEventByID(nowUser.administratedEvents[indexPath.row - 1]).name
            cell.imageView?.image = UIImage(systemName: "person.3")
            return cell
        }
        
    }
    
}


class DetailedAccountView: UIViewController {
    var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class DetailedEventView: UIViewController {
    var selectedEvent: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
