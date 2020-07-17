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
    var nowUser = testuser_1
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Отвечает за количество строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + nowUser.returnAdministratedEvents(storage: everythingStorage).count
    }
    
    // Отвечает за то, куда перейдет пользователь после тапа по строчке
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "detailedAccountView") as? DetailedAccountView {
                vc.selectedUser = everythingStorage?.nowUser
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "detailedEventView") as? DetailedEventView {
                vc.selectedEvent = everythingStorage?.getEventByID(ID: nowUser.returnAdministratedEvents(storage: everythingStorage)[indexPath.row - 1])
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // Отвечает за то, какой контент находится на строчке
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountItem", for: indexPath)
            print("account")
            cell.textLabel?.text = nowUser.name
            cell.imageView?.image = UIImage(systemName: "person")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventItem", for: indexPath)
            print("event")
            cell.textLabel?.text = everythingStorage?.getEventByID(ID: nowUser.returnAdministratedEvents(storage: everythingStorage)[indexPath.row - 1])?.name
            cell.imageView?.image = UIImage(systemName: "person.3")
            return cell
        }
        
    }
    
}


class DetailedAccountView: UIViewController {
    var selectedUser: User?
    @IBOutlet var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = selectedUser?.name
    }
}

class DetailedEventView: UIViewController {
    var selectedEvent: Event?
    @IBOutlet var nameOfEvent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameOfEvent.text = selectedEvent?.name
    }
}
