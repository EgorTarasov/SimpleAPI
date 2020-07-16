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
               
    }
}

class AccountMenuView: UITableViewController {
    var everythingStorage: InternalStorage? = testEverythingStorage
    var nowUser = test_User1
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
                vc.selectedUser = everythingStorage?.nowUser
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "AdministratedEventItem") as? DetailedEventView {
                vc.selectedEvent = everythingStorage?.getEventByID(ID: nowUser.administratedEvents[indexPath.row - 1])
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
            cell.textLabel?.text = everythingStorage?.getEventByID(ID: nowUser.administratedEvents[indexPath.row - 1]).name
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
