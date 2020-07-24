//
//  UsersList.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 24.07.2020.
//

import Foundation
import UIKit
import Firebase

class UsersListViewController: UITableViewController {
    var selectedEvent: Event?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedEvent?.willGoUsers.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath)
        var user = User()
        if let usernameID = selectedEvent?.willGoUsers[indexPath.row] {
            user.getUserByID(usernameID, user)
            cell.textLabel?.text = user.name
        } else {
            cell.textLabel?.text = "Ошибка получения пользователя"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "accountDetail") as? AccountDetailViewController {
            if let usernameID = selectedEvent?.willGoUsers[indexPath.row] {
                var user = User()
                user.getUserByID(usernameID, user)
                vc.selectedUser = user
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
