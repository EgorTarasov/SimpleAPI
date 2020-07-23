//
//  EventMenu.swift
//  ArrangeIt
//


import UIKit


class EventMenuNavigationController: UINavigationController {
    
}

class EventMenuViewController: UITableViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseCover.shared.getNowUser()?.willGoEvents.count ?? 0 + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let list = FirebaseCover.shared.getNowUser()?.willGoEvents && indexPath.row != 0 а{
            let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath)
            cell.textLabel?.text = FirebaseCover.shared.getEventByID(list[indexPath.row])?.name
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath)
            cell.
        }
    }
}
